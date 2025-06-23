import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tenderiq_frontend/blocks/widget.dart';
import 'package:tenderiq_frontend/screens/login_page.dart';
import 'dart:convert';

class AdminPage extends StatefulWidget {
  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  String? _pdfUrl;
  bool _isUploading = false;
  Map<String, dynamic>? data;

  // New state variables for prototype UI
  bool _showTenderInfo = false;
  bool _showBanner = false;
  bool _isFakeUploading = false;

  @override
  void initState() {
    super.initState();
    _loadJson();
    // Start 35s delay for TenderInfoBlocks
    Future.delayed(const Duration(seconds: 35), () {
      if (mounted) setState(() => _showTenderInfo = true);
    });
  }

  Future<void> _pickAndUploadPdf() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
      withData: true,
    );

    if (result == null || result.files.single.bytes == null) return;

    final fileBytes = result.files.single.bytes!;
    final fileName = result.files.single.name;
    final fileSize = fileBytes.length;

    setState(() => _isUploading = true);

    final ref = FirebaseStorage.instance.ref().child('uploads/$fileName');

    try {
      final metadata = await ref.getMetadata();
      final cloudSize = metadata.size ?? -1;

      if (cloudSize == fileSize) {
        final url = await ref.getDownloadURL();
        setState(() {
          _pdfUrl = url;
          _isUploading = false;
        });
        print('Skipped upload. File already exists: $url');
        return;
      }
    } catch (e) {
      // Ignore if file doesn't exist
    }

    // Upload with proper metadata
    await ref.putData(
      fileBytes,
      SettableMetadata(
        contentType: 'application/pdf',
        customMetadata: {'uploaded_by': 'admin_page'},
        // Unfortunately, `contentDisposition` needs to be passed like this:
        contentDisposition: 'inline',
      ),
    );

    final url = await ref.getDownloadURL();
    setState(() {
      _pdfUrl = url;
      _isUploading = false;
    });

    print('Uploaded and available at: $url');
  }

  Future<void> _loadJson() async {
    // Simulating JSON loading from local data
    const jsonString = '''
{
  "overview": {
    "tags": ["Tourism", "Heritage", "Construction"],
    "location": "Ahmednagar Fort, Tal & Dist Ahilyanagar, Maharashtra",
    "opening_date": "2025-06-04",
    "closing_date": "2025-06-12",
    "amount": "₹13.34 Crore",
    "type": "e-Tender / NCB",
    "portal_url": "https://mahatenders.gov.in"
  },
  "ai_recommendation": {
    "fit_score": 88,
    "matching_summary": "Matches your civil heritage project experience.",
    "unmatched_summary": "May require specialized historical restoration credentials.",
    "highlights": [
      "Heritage site civil development",
      "EMD & Performance Guarantees specified",
      "Key equipment and staff requirements enforced"
    ]
  },
  "risk_flags": {
    "red": "Strict milestone and performance guarantees",
    "orange": "Short bid preparation window",
    "yellow": "No joint venture allowed"
  },
  "basic_details": {
    "organization_chain": "Directorate of Tourism, Government of Maharashtra",
    "tender_reference_number": "B-2/EE/DoT/",
    "tender_id": "2025_TOURISM_001",
    "evaluation_allowed": true,
    "payment_mode": "Online",
    "multi_currency": false,
    "withdrawal_allowed": true,
    "form_of_contract": "B-2",
    "no_of_covers": 2,
    "inviting_authority_name": "Executive Engineer, Directorate of Tourism",
    "inviting_authority_address": "Directorate of Tourism, Mumbai"
  },
  "emd_fee_details": {
    "amount": "₹6,68,000",
    "fee_type": "Fixed",
    "payable_to": "Executive Engineer, Directorate of Tourism",
    "payable_at": "Mumbai"
  },
  "work_item_details": {
    "title": "Development of Ahmednagar Fort, Tal & Dist Ahilyanagar Under CBDD Swadesh Darshan 2.0",
    "description": "Development and restoration of Ahmednagar Fort under Swadesh Darshan 2.0 scheme",
    "nda_prequalification": "Site inspection report, Experience in Monumental Restoration",
    "remarks": "Subject to strict timeline and performance clauses",
    "tender_value": "₹13.34 Crore",
    "product_category": "Civil Works"
  },
  "critical_dates": [
    {
      "event": "Bid Submission Start Date",
      "key_date": "2025-06-04",
      "days_left": -19
    },
    {
      "event": "Bid Submission End Date",
      "key_date": "2025-06-12",
      "days_left": -11
    },
    {
      "event": "Technical Bid Opening Date",
      "key_date": "2025-06-13",
      "days_left": -10
    }
  ],
  "tender_documents": [
    {
      "name": "Tender Notice",
      "url": "https://mahatenders.gov.in/doc/notice.pdf",
      "size": "300 KB"
    },
    {
      "name": "BoQ",
      "url": "https://mahatenders.gov.in/doc/boq.xlsx",
      "size": "200 KB"
    }
  ],
  "financial_requirements": {
    "estimated_value": "₹13.34 Crore",
    "cost_breakdown": {
      "base_scope": "₹12 Crore",
      "taxes": "₹1 Crore",
      "other_charges": "₹0.34 Crore"
    },
    "bid_security_amount": "₹6,68,000",
    "bid_security_format": ["BG", "Online"],
    "bid_security_validity": "180 days from bid submission",
    "document_fee_amount": "₹10,000",
    "document_fee_mode": "Online",
    "performance_guarantee": {
      "percentage": "5%",
      "value": "₹66,800"
    },
    "guarantee_triggers": "Applicable on discounts beyond 10%",
    "advance_payment_terms": "Mobilization advance of 10% on approval",
    "tax_clauses": "GST @18%, TDS @2%"
  },
  "legal_terms": {
    "form_of_contract": "B-2",
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
    if (_isUploading || _pdfUrl == null || data == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Tender IQ",
            style: TextStyle(color: Colors.black87),
          ),
          backgroundColor: Colors.white,
          elevation: 0.5,
          automaticallyImplyLeading: false,
          actions: [
            ElevatedButton.icon(
              icon: const Icon(Icons.logout),
              label: const Text("Logout"),
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                await prefs.remove('usertype');
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const LoginPage()),
                  (route) => false,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(width: 16),
          ],
        ),
        body: Center(
          child:
              _isUploading
                  ? const CircularProgressIndicator()
                  : ElevatedButton.icon(
                    onPressed: _pickAndUploadPdf,
                    icon: const Icon(Icons.upload_file),
                    label: const Text("Upload PDF"),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 16,
                      ),
                    ),
                  ),
        ),
      );
    }

    Widget mainContent;
    if (!_showTenderInfo) {
      mainContent = const Center(child: CircularProgressIndicator());
    } else if (_isFakeUploading) {
      mainContent = const Center(child: CircularProgressIndicator());
    } else {
      mainContent = Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Stack(
                  children: [
                    SfPdfViewer.network(
                      'https://raw.githubusercontent.com/Conceptatlead/repo/964d7dd8aa8bab2a8c719388c701f90a20f8d90f/18601tenderDTP.pdf',
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _pdfUrl = null;
                            _showTenderInfo = false;
                            _isFakeUploading = false;
                            _showBanner = false;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.close, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child:
                _isFakeUploading
                    ? const Center(child: CircularProgressIndicator())
                    : !_showTenderInfo
                    ? const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(height: 16),
                          Text('Data is being extracted from PDF...'),
                        ],
                      ),
                    )
                    : TenderInfoBlocks(data: data!),
          ),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Tender IQ", style: TextStyle(color: Colors.black87)),
        backgroundColor: Colors.white,
        elevation: 0.5,
        automaticallyImplyLeading: false,
        actions: [
          ElevatedButton.icon(
            icon: const Icon(Icons.logout),
            label: const Text("Logout"),
            onPressed: () async {
              final prefs = await SharedPreferences.getInstance();
              await prefs.remove('usertype');
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const LoginPage()),
                (route) => false,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Stack(
        children: [
          mainContent,
          if (_showBanner)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: MaterialBanner(
                content: const Text('Data is uploaded'),
                backgroundColor: Colors.green.shade100,
                actions: [
                  TextButton(
                    onPressed: () {
                      setState(() => _showBanner = false);
                    },
                    child: const Text('DISMISS'),
                  ),
                ],
              ),
            ),
        ],
      ),
      floatingActionButton:
          _showTenderInfo && !_isFakeUploading
              ? FloatingActionButton(
                onPressed: () async {
                  setState(() => _isFakeUploading = true);
                  await Future.delayed(const Duration(seconds: 5));
                  if (!mounted) return;
                  setState(() {
                    _isFakeUploading = false;
                    _showBanner = true;
                  });
                  await Future.delayed(const Duration(seconds: 5));
                  if (mounted) setState(() => _showBanner = false);
                },
                child: const Icon(Icons.upload),
              )
              : null,
    );
  }
}
