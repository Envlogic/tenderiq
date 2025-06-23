import os
import json
import requests
import firebase_admin
from firebase_admin import initialize_app
from firebase_functions import https_fn, options
from firebase_functions.options import set_global_options
import google.genai as genai 
import psycopg2
from psycopg2.extras import RealDictCursor

# ──────────────────────────────────────────────
# Set global options
# ──────────────────────────────────────────────
set_global_options(
    secrets=["GEMINI_API_KEY", "DB_NAME", "DB_USER", "DB_PASSWORD", "DB_HOST", "INSTANCE_CONNECTION_NAME"],
    min_instances=0
)

# ──────────────────────────────────────────────
# Firebase Admin SDK Init
# ──────────────────────────────────────────────
if not firebase_admin._apps:
    initialize_app()

# ──────────────────────────────────────────────
# Gemini Model Wrapper (google-genai)
# ──────────────────────────────────────────────
def call_gemini_model(system_prompt: str, user_prompt: str, gemini_api_key: str) -> str:
    genai.configure(api_key=gemini_api_key)
    model = genai.GenerativeModel(model_name="models/gemini-2.5-flash")  
    chat = model.start_chat()
    response = chat.send_message(f"{system_prompt}\n\n{user_prompt}")
    return response.text.strip()

# ──────────────────────────────────────────────
# GraphQL Helpers
# ──────────────────────────────────────────────
def get_graphql_headers():
    access_token = firebase_admin.get_app().credential.get_access_token().access_token
    return {
        "Content-Type": "application/json",
        "Authorization": f"Bearer {access_token}"
    }

def run_graphql_query(graphql_endpoint: str, query: str, variables=None):
    response = requests.post(
        graphql_endpoint,
        headers=get_graphql_headers(),
        json={"query": query, "variables": variables or {}},
        timeout=10
    )
    response.raise_for_status()
    return response.json()["data"]

# ──────────────────────────────────────────────
# Cloud SQL (PostgreSQL) Connection Helper
# ──────────────────────────────────────────────
def get_db_connection():
    db_host = os.environ["DB_HOST"]
    print("DB_HOST:", os.environ.get("DB_HOST"))
    # Use Unix socket in prod
    if db_host == "socket":
        return psycopg2.connect(
            dbname=os.environ["DB_NAME"],
            user=os.environ["DB_USER"],
            password=os.environ["DB_PASSWORD"],
            host=f"/cloudsql/{os.environ['INSTANCE_CONNECTION_NAME']}",
            cursor_factory=RealDictCursor
        )
    # Use TCP for local (via proxy)
    return psycopg2.connect(
        dbname=os.environ["DB_NAME"],
        user=os.environ["DB_USER"],
        password=os.environ["DB_PASSWORD"],
        host=db_host,
        port=os.environ.get("DB_PORT", 5432),
        cursor_factory=RealDictCursor
    )

def fetch_one(query, params=None):
    with get_db_connection() as conn:
        with conn.cursor() as cur:
            cur.execute(query, params)
            return cur.fetchone()

def fetch_all(query, params=None):
    with get_db_connection() as conn:
        with conn.cursor() as cur:
            cur.execute(query, params)
            return cur.fetchall()

# ──────────────────────────────────────────────
# AI Search Endpoint
# ──────────────────────────────────────────────
@https_fn.on_request(
    secrets=["GEMINI_API_KEY", "DB_NAME", "DB_USER", "DB_PASSWORD", "DB_HOST", "INSTANCE_CONNECTION_NAME"],
    min_instances=0,
    max_instances=1
)
def ai_search(req: https_fn.Request) -> https_fn.Response:
    if req.method == "OPTIONS":
        response = https_fn.Response("", status=204)
        response.headers["Access-Control-Allow-Origin"] = "*"
        response.headers["Access-Control-Allow-Headers"] = "Content-Type"
        response.headers["Access-Control-Allow-Methods"] = "POST, OPTIONS"
        return response

    try:
        data = req.get_json()
        user_id = data.get("userId")
        if not user_id or "query" not in data:
            response = https_fn.Response("Missing userId or query", status=400)
            response.headers["Access-Control-Allow-Origin"] = "*"
            response.headers["Access-Control-Allow-Headers"] = "Content-Type"
            response.headers["Access-Control-Allow-Methods"] = "POST, OPTIONS"
            return response

        # 1. Get user info
        user_info = fetch_one('''
            SELECT u.id, u.full_name, u.email, u.profile_pic_url, up.preferred_categories, up.preferred_locations, up.notification_enabled, up.language, ua.tenders_followed, ua.tenders_submitted
            FROM "user" u
            LEFT JOIN user_preference up ON up.user_id = u.id
            LEFT JOIN user_activity ua ON ua.user_id = u.id
            WHERE u.id = %s
        ''', (user_id,))

        # 2. Manual search queries
        manual_queries = fetch_all('''
            SELECT query_text, timestamp
            FROM manual_search_query
            WHERE user_id = %s
            ORDER BY timestamp DESC
            LIMIT 10
        ''', (user_id,))

        # 3. AI query clicks
        ai_clicks = fetch_all('''
            SELECT query_text, timestamp
            FROM ai_suggested_query_click
            WHERE user_id = %s
            ORDER BY timestamp DESC
            LIMIT 10
        ''', (user_id,))

        # 4. Tender feed
        tenders = fetch_all('''
            SELECT t.id, t.title, t.tags, t.location, t.tender_amount, t.closing_date, tbd.tender_category, wid.title AS work_title, wid.description, wid.product_category, wid.contract_type, air.fit_score, air.matching_criteria_summary, raf.red_flags, raf.orange_flags, raf.yellow_flags, o.name AS organization_name
            FROM tender t
            LEFT JOIN tender_basic_detail tbd ON tbd.tender_id = t.id
            LEFT JOIN work_item_detail wid ON wid.tender_id = t.id
            LEFT JOIN ai_recommendation air ON air.tender_id = t.id
            LEFT JOIN risk_alert_flag raf ON raf.tender_id = t.id
            LEFT JOIN organization o ON t.organization_id = o.id
            ORDER BY t.closing_date ASC
            LIMIT 25 OFFSET 0
        ''')

        prompt = (
            f"User '{user_info['full_name']}' prefers categories {user_info['preferred_categories']} "
            f"in {user_info['preferred_locations']}, with past queries "
            f"{[q['query_text'] for q in manual_queries]} and AI clicks {[q['query_text'] for q in ai_clicks]} .\n"
            f"Available tenders:\n{json.dumps(tenders, indent=2)}\n"
            f"User search request: {data['query']}\n"
            "Return top 3 matching tenders, each with a short reason (JSON array)."
        )

        answer = call_gemini_model("You are a tender recommendation assistant.", prompt, os.environ["GEMINI_API_KEY"])
        response = https_fn.Response(answer, mimetype="application/json")
        response.headers["Access-Control-Allow-Origin"] = "*"
        response.headers["Access-Control-Allow-Headers"] = "Content-Type"
        response.headers["Access-Control-Allow-Methods"] = "POST, OPTIONS"
        return response

    except Exception as e:
        response = https_fn.Response(f"AI Search Error: {str(e)}", status=500)
        response.headers["Access-Control-Allow-Origin"] = "*"
        response.headers["Access-Control-Allow-Headers"] = "Content-Type"
        response.headers["Access-Control-Allow-Methods"] = "POST, OPTIONS"
        return response

# ──────────────────────────────────────────────
# AI Suggestion Endpoint
# ──────────────────────────────────────────────
@https_fn.on_request(
    secrets=["GEMINI_API_KEY", "DB_NAME", "DB_USER", "DB_PASSWORD", "DB_HOST", "INSTANCE_CONNECTION_NAME"],
    min_instances=0,
    max_instances=1
)
def ai_suggestion(req: https_fn.Request) -> https_fn.Response:
    if req.method == "OPTIONS":
        response = https_fn.Response("", status=204)
        response.headers["Access-Control-Allow-Origin"] = "*"
        response.headers["Access-Control-Allow-Headers"] = "Content-Type"
        response.headers["Access-Control-Allow-Methods"] = "POST, OPTIONS"
        return response

    try:
        data = req.get_json()
        user_id = data.get("userId")
        if not user_id:
            response = https_fn.Response("Missing userId", status=400)
            response.headers["Access-Control-Allow-Origin"] = "*"
            response.headers["Access-Control-Allow-Headers"] = "Content-Type"
            response.headers["Access-Control-Allow-Methods"] = "POST, OPTIONS"
            return response

        # Use the provided SQL for GetAISuggestionContext
        suggestion_sql = '''
        WITH user_info AS (
          SELECT u.id AS user_id, u.full_name, u.email, u.profile_pic_url, up.preferred_categories, up.preferred_locations, ua.tenders_followed, ua.tenders_submitted, c.id AS company_id, c.name AS company_name, c.gstin, c.contact_number
          FROM "user" u
          LEFT JOIN user_preference up ON up.user_id = u.id
          LEFT JOIN user_activity ua ON ua.user_id = u.id
          LEFT JOIN company c ON u.company_id = c.id
          WHERE u.id = %s
        ),
        company_stats AS (
          SELECT cbs.company_id, cbs.total_tenders, cbs.tenders_won, cbs.win_rate_pct::FLOAT, cbs.average_tender_value::FLOAT, cbs.max_tender_won::FLOAT, cbs.average_bid_amount::FLOAT, cbs.top_categories, cbs.active_categories, cbs.recent_tender_range_bucket, cbs.last_updated
          FROM company_bid_stats cbs
          WHERE cbs.company_id = (SELECT company_id FROM user_info)
        ),
        manual_queries AS (
          SELECT query_text, timestamp FROM manual_search_query WHERE user_id = (SELECT user_id FROM user_info) ORDER BY timestamp DESC LIMIT 10
        ),
        ai_clicks AS (
          SELECT query_text, timestamp FROM ai_suggested_query_click WHERE user_id = (SELECT user_id FROM user_info) ORDER BY timestamp DESC LIMIT 10
        ),
        bid_history AS (
          SELECT b.bid_amount::FLOAT, b.tender_value::FLOAT, b.bid_status, b.submitted_at, b.result_date, b.participation_type, b.remarks, b.award_value::FLOAT, b.work_start_date, b.work_end_date, b.bid_category, b.tender_range_bucket, t.id AS tender_id, t.title AS tender_title, t.tags::TEXT[] AS tags, t.location, t.closing_date, tbd.tender_category, wid.product_category, wid.description
          FROM tender_bid_history b
          JOIN tender t ON b.tender_id = t.id
          LEFT JOIN tender_basic_detail tbd ON tbd.tender_id = t.id
          LEFT JOIN work_item_detail wid ON wid.tender_id = t.id
          WHERE b.user_id = (SELECT user_id FROM user_info)
          ORDER BY b.submitted_at DESC
          LIMIT 10
        )
        SELECT ui.*, cs.*, mq.query_text AS manual_query_text, mq.timestamp AS manual_query_timestamp, ac.query_text AS ai_click_text, ac.timestamp AS ai_click_timestamp, bh.*
        FROM user_info ui
        LEFT JOIN company_stats cs ON true
        LEFT JOIN manual_queries mq ON true
        LEFT JOIN ai_clicks ac ON true
        LEFT JOIN bid_history bh ON true;
        '''
        suggestion_ctx = fetch_all(suggestion_sql, (user_id,))
        # Use the first row for company stats
        stats = suggestion_ctx[0] if suggestion_ctx else {}
        prompt = (
            f"Company has win rate {stats.get('win_rate_pct', 'N/A')}%, top categories {stats.get('top_categories', 'N/A')}, "
            f"active categories {stats.get('active_categories', 'N/A')}, average bid ₹{stats.get('average_bid_amount', 'N/A')}, "
            f"tender range {stats.get('recent_tender_range_bucket', 'N/A')}.\n"
            "Suggest 3 personalized tender search queries (JSON array of strings)."
        )
        answer = call_gemini_model("You are a tender suggestion assistant.", prompt, os.environ["GEMINI_API_KEY"])
        response = https_fn.Response(answer, mimetype="application/json")
        response.headers["Access-Control-Allow-Origin"] = "*"
        response.headers["Access-Control-Allow-Headers"] = "Content-Type"
        response.headers["Access-Control-Allow-Methods"] = "POST, OPTIONS"
        return response

    except Exception as e:
        response = https_fn.Response(f"AI Suggestion Error: {str(e)}", status=500)
        response.headers["Access-Control-Allow-Origin"] = "*"
        response.headers["Access-Control-Allow-Headers"] = "Content-Type"
        response.headers["Access-Control-Allow-Methods"] = "POST, OPTIONS"
        return response
