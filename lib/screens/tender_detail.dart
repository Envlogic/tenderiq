import 'package:flutter/material.dart';
import 'package:tenderiq_frontend/blocks/widget.dart';
import 'package:tenderiq_frontend/components/chatbot.dart';
import '../generated/default_connector/default.dart';
import 'dart:convert';

class TenderDetail extends StatefulWidget {
  final String tenderId;
  final String? tenderTitle;
  const TenderDetail({super.key, required this.tenderId, this.tenderTitle});

  @override
  State<TenderDetail> createState() => _TenderDetailState();
}

class _TenderDetailState extends State<TenderDetail> {
  late Future<GetTenderDetailsTender?> _futureTender;

  @override
  void initState() {
    super.initState();
    _futureTender = _fetchTenderDetails();
    _loadJson();
  }

  Future<GetTenderDetailsTender?> _fetchTenderDetails() async {
    final builder = DefaultConnector.instance.getTenderDetails(
      tenderId: widget.tenderId,
    );
    final result = await builder.execute();
    return result.data.tender;
  }

  Map<String, dynamic>? data;

  Future<void> _loadJson() async {
    // Simulating JSON loading from local data
    const jsonString = '''
    {
  "overview": {
    "tags": ["Construction", "highway"],
    "location": "Ahemdabad, Gujarat",
    "opening_date": "2025-06-25",
    "closing_date": "2025-07-10",
    "amount": "₹25 Crore",
    "type": "Open Tender",
    "portal_url": "https://eprocure.gov.in"
  },
  "ai_recommendation": {
    "fit_score": 92,
    "matching_summary": "Matches your eligibility and past experience in 3 key areas.",
    "unmatched_summary": "Requires ISO certification; missing environmental clearance.",
    "highlights": [
      "High value government tender",
      "Located within your service zone",
      "5-year maintenance opportunity"
    ]
  },
  "risk_flags": {
    "red": "Bidding terms changed multiple times",
    "orange": "Shorter than usual bid preparation time",
    "yellow": "Requires consortium partners"
  },
  "basic_details": {
    "organization_chain": "Ministry of Road Transport & Highways",
    "tender_reference_number": "MORTH/NH/2025/001",
    "tender_id": "2025_MORTH_001",
    "evaluation_allowed": true,
    "payment_mode": "Offline/Online",
    "multi_currency": false,
    "withdrawal_allowed": true,
    "form_of_contract": "Item Rate",
    "no_of_covers": 2,
    "inviting_authority_name": "Chief Engineer, MoRTH",
    "inviting_authority_address": "Transport Bhawan, Parliament Street, New Delhi"
  },
  "emd_fee_details": {
    "amount": "₹5,00,000",
    "fee_type": "Fixed",
    "payable_to": "Executive Engineer, NH Division",
    "payable_at": "Panaji, Goa"
  },
  "work_item_details": {
    "title": "Four-laning of NH-66",
    "description": "Development of 4-lane highway from Goa border to Mangalore stretch.",
    "nda_prequalification": "Class-I Contractor License, ISO Certification",
    "remarks": "Independent Quality Assurance will be monitored",
    "tender_value": "₹45 Crore",
    "product_category": "Civil Works - Highways"
  },
  "costs": {
    "description": "Estimated construction and supervision costs",
    "contact": {
      "tender_id": "2025_MORTH_001",
      "tender_number": "NH/2025/Goa",
      "authority": "Chief Engineer, MoRTH"
    }
  },
  "critical_dates": [
    {
      "event": "Bid Submission Start Date",
      "key_date": "2025-06-25",
      "days_left": 5
    },
    {
      "event": "Bid Submission End Date",
      "key_date": "2025-07-10",
      "days_left": 20
    },
    {
      "event": "Technical Bid Opening Date",
      "key_date": "2025-07-12",
      "days_left": 22
    }
  ],
  "tender_documents": [
    {
      "name": "Tender Notice",
      "url": "https://eprocure.gov.in/doc/notice.pdf",
      "size": "250 KB"
    },
    {
      "name": "BoQ",
      "url": "https://eprocure.gov.in/doc/boq.xlsx",
      "size": "150 KB"
    }
  ],
  "financial_requirements": {
    "estimated_value": "₹45 Crore",
    "cost_breakdown": {
      "base_scope": "₹40 Crore",
      "taxes": "₹3 Crore",
      "other_charges": "₹2 Crore"
    },
    "bid_security_amount": "₹5 Lakh",
    "bid_security_format": ["BG", "FDR", "Online", "Cheque"],
    "bid_security_validity": "180 days from bid submission",
    "document_fee_amount": "₹10,000",
    "document_fee_mode": "Online",
    "performance_guarantee": {
      "percentage": "5%",
      "value": "₹2.25 Crore"
    },
    "guarantee_triggers": "Applicable on discounts beyond 10%",
    "advance_payment_terms": "Mobilization advance of 10% on approval",
    "tax_clauses": "GST @18%, TDS @2%"
  },
  "eligibility_criteria": {
    "min_turnover": "₹20 Crore/year for last 3 years",
    "experience_requirements": {
      "similar_contracts": 2,
      "min_value_per_contract": "₹10 Crore"
    },
    "definition_similar_work": "Highway construction with bituminous surfacing",
    "min_quantity_benchmark": "20 KM",
    "key_personnel": "Project Manager with 15 years’ experience",
    "equipment_requirements": ["Paver Finisher", "Hot Mix Plant"],
    "site_visit_required": true,
    "jv_rules": {
      "allowed": true,
      "minimum_share": "40%"
    },
    "litigation_blacklist": "No history in last 5 years",
    "financial_evidence": "Audited statements, Net worth > ₹15 Cr",
    "misc": "CA certified turnover statement needed"
  },
  "submission_instructions": {
    "submission_mode": "Online",
    "bid_structure": ["Technical", "Financial"],
    "file_formats": ["PDF", "XLSX", "ZIP"],
    "digital_signature_required": true,
    "physical_address": "Transport Bhawan, New Delhi",
    "number_of_copies": "Softcopy only",
    "document_checklist": ["Bid Form", "BoQ", "Work Experience Certificates"],
    "security_clause": "Files must be virus-free",
    "misc": "Late submissions not allowed"
  },
  "evaluation_award": {
    "method": "L1",
    "weightages": {
      "technical": "70%",
      "financial": "30%"
    },
    "responsiveness": "Bid must be complete and signed",
    "arithmetic_rules": "Rounding off to nearest rupee",
    "bid_capacity": "As per NIT Clause 6.3",
    "negotiation": "May be conducted after financial evaluation",
    "award_rules": "Lowest responsive bidder",
    "notification_timeline": "Within 7 days of final evaluation",
    "misc": "No appeal once award is made"
  },
  "legal_terms": {
    "form_of_contract": "EPC Agreement",
    "performance_release": "After 12 months of defect liability",
    "penalties": "1% per week of delay, max 10%",
    "forfeiture_conditions": "Non-submission of BG",
    "force_majeure": "As per standard contract clause",
    "dispute_resolution": "Arbitration under ICA rules",
    "anti_corruption": "As per CVC Guidelines",
    "termination_clauses": "In case of breach or delay > 60 days",
    "misc": "Complies with Indian Contract Act"
  },
  "post_award": {
    "advance_schedule": "10% within 15 days of signing",
    "progress_reporting": "Monthly report with photos",
    "quality_control": "Third-party labs to verify test results",
    "milestones_payment": "30%-30%-40% linked to work stages",
    "warranty_period": "2 years from final completion",
    "handover_date": "2027-06-30",
    "misc": "Final audit required before closure"
  }
}

    ''';

    setState(() {
      data = json.decode(jsonString);
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<GetTenderDetailsTender?>(
      future: _futureTender,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting ||
            data == null) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(title: const Text('Error')),
            body: Center(child: Text('Error: \\${snapshot.error}')),
          );
        } else if (!snapshot.hasData || snapshot.data == null) {
          return Scaffold(
            appBar: AppBar(title: Text('Tender Not Found')),
            body: Center(child: Text('Tender not found.')),
          );
        }
        final tender = snapshot.data!;
        final appBarTitle =
            widget.tenderTitle ??
            tender.workItemDetail?.title ??
            tender.tenderRefNo ??
            tender.id;
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 1,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black87),
              onPressed: () => Navigator.pop(context),
            ),
            title: Text(
              appBarTitle,
              style: const TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left content blocks
                Expanded(flex: 2, child: TenderInfoBlocks(data: data!)),

                const SizedBox(width: 20),

                // Right chatbot panel
                Expanded(child: Chatbot(data: data)),
              ],
            ),
          ),
        );
      },
    );
  }
}
