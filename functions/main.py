import os
import json
import re
from google import genai
from google.genai import types
from firebase_functions import https_fn

# ──────────────────────────────────────────────
# Gemini Client Setup
# ──────────────────────────────────────────────
# client = genai.Client(api_key=os.environ["GEMINI_API_KEY"])
client = genai.Client(api_key="")


# ──────────────────────────────────────────────
# Gemini Model Call
# ──────────────────────────────────────────────
def call_gemini_model(system_prompt: str, user_prompt: str, model_name: str) -> str:
    full_prompt = f"{system_prompt.strip()}\n\n{user_prompt.strip()}"

    response = client.models.generate_content(
        model=model_name,
        contents=full_prompt,
        config=types.GenerateContentConfig(
            temperature=0.7,
            max_output_tokens=1024
        )
    )

    return response.text.strip()

def extract_json_array(text):
    # Find the first [ ... ] block in the text
    match = re.search(r'\[\s*[\s\S]*\]', text)
    if match:
        return match.group(0)
    return text

# ──────────────────────────────────────────────
# AI Search Endpoint
# ──────────────────────────────────────────────
@https_fn.on_request(
    secrets=["GEMINI_API_KEY"],
    min_instances=0,
    max_instances=1
)
def ai_search(req: https_fn.Request) -> https_fn.Response:
    if req.method == "OPTIONS":
        return _cors_response()

    if not req.headers.get("Content-Type", "").startswith("application/json"):
        return _error("Invalid Content-Type. Must be application/json", 400)

    try:
        data = req.get_json()
        ai_search_context = data.get("aiSearchContext")
        user_query = data.get("query")

        if not ai_search_context or not user_query:
            return _error("Missing aiSearchContext or query", 400)

        model_name = "gemini-2.0-flash-lite"

        system_prompt = """
You are a multi-agent AI tender search system built using Google ADK. The system has the following agents:

1. **User Analyst Agent**: Understands user profile, preferences, past activity, and recent behavior.
2. **Tender Analyst Agent**: Analyzes each tender's features like location, category, budget, risk, etc.
3. **Matching Agent**: Computes semantic similarity between tenders and user query/context.
4. **Recommendation Formatter Agent**: Prepares final ranked list of tenders with short explanations.

Your task:
- Parse the `user_query` and `ai_search_context` (JSON).
- Let the agents work sequentially to produce the top 5 tender recommendations.
- Output should be a **JSON array**. Each tender must include:
  - `title`
  - `tags`
  - `location`
  - `tender_amount`
  - `fit_score`
  - `reason` (why it was recommended)

Think step-by-step like a real multi-agent system and simulate their decision-making.
"""

        user_prompt = f"""
User Query: {user_query}
Context JSON:\n{json.dumps(ai_search_context, indent=2)}
"""

        answer = call_gemini_model(system_prompt, user_prompt, model_name)
        json_array_str = extract_json_array(answer)
        return _success(json_array_str)

    except Exception as e:
        return _error(f"AI Search Error: {str(e)}", 500)

# ──────────────────────────────────────────────
# AI Suggestion Endpoint
# ──────────────────────────────────────────────
@https_fn.on_request(
    secrets=["GEMINI_API_KEY"],
    min_instances=0,
    max_instances=1
)
def ai_suggestion(req: https_fn.Request) -> https_fn.Response:
    if req.method == "OPTIONS":
        return _cors_response()

    if not req.headers.get("Content-Type", "").startswith("application/json"):
        return _error("Invalid Content-Type. Must be application/json", 400)

    try:
        data = req.get_json()
        ai_suggestion_context = data.get("aiSuggestionContext")

        if not ai_suggestion_context:
            return _error("Missing aiSuggestionContext", 400)

        model_name = "gemma-3-1b-it"

        system_prompt = """
You are a multi-agent tender query suggestion system.
Analyze the full context of the user and company to generate 3–5 unique, personalized, and relevant tender **search queries**.

Return a JSON array of strings. Each query must:
- Reflect the company’s bidding behavior, wins/losses, and strengths
- Be different in category or focus
- Be practically useful for discovering tenders
"""

        user_prompt = f"""
Context JSON:\n{json.dumps(ai_suggestion_context, indent=2)}
"""

        answer = call_gemini_model(system_prompt, user_prompt, model_name)
        json_array_str = extract_json_array(answer)
        return _success(json_array_str)

    except Exception as e:
        return _error(f"AI Suggestion Error: {str(e)}", 500)

# ──────────────────────────────────────────────
# Simple LLM Chat Endpoint for Chatbot
# ──────────────────────────────────────────────
@https_fn.on_request(
    secrets=["GEMINI_API_KEY"],
    min_instances=0,
    max_instances=1
)
def ai_chatbot(req: https_fn.Request) -> https_fn.Response:
    if req.method == "OPTIONS":
        return _cors_response()

    if not req.headers.get("Content-Type", "").startswith("application/json"):
        return _error("Invalid Content-Type. Must be application/json", 400)

    try:
        data = req.get_json()
        llm_context = data.get("llmContext")
        user_query = data.get("query")

        if not llm_context or not user_query:
            return _error("Missing llmContext or query", 400)

        model_name = "gemini-2.0-flash-lite"

        system_prompt = """
You are a helpful AI assistant for tender analysis. Use the provided context JSON to answer the user's question as accurately and concisely as possible. If the answer is not in the context, say so politely.
"""

        user_prompt = f"""
User Query: {user_query}
Context JSON:\n{json.dumps(llm_context, indent=2)}
"""

        answer = call_gemini_model(system_prompt, user_prompt, model_name)
        return _success(json.dumps({"response": answer}))

    except Exception as e:
        return _error(f"AI Chatbot Error: {str(e)}", 500)

# ──────────────────────────────────────────────
# CORS & Utility Handlers
# ──────────────────────────────────────────────
def _cors_response():
    response = https_fn.Response("", status=204)
    _set_cors_headers(response)
    return response

def _success(data: str):
    try:
        json_data = json.loads(data)
        response = https_fn.Response(json.dumps(json_data), mimetype="application/json")
    except Exception:
        response = https_fn.Response(json.dumps({"error": "Invalid JSON from model", "raw": data}), mimetype="application/json")
    _set_cors_headers(response)
    return response

def _error(message: str, status: int):
    response = https_fn.Response(message, status=status)
    _set_cors_headers(response)
    return response

def _set_cors_headers(response):
    response.headers["Access-Control-Allow-Origin"] = "*"
    response.headers["Access-Control-Allow-Headers"] = "Content-Type"
    response.headers["Access-Control-Allow-Methods"] = "POST, OPTIONS"
