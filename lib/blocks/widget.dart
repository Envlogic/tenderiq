import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TenderInfoBlocks extends StatelessWidget {
  final Map<String, dynamic> data;
  const TenderInfoBlocks({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          OverviewBlock(data: data['overview']),
          const SizedBox(height: 16),
          AIRecommendationBlock(data: data['ai_recommendation']),
          const SizedBox(height: 16),
          RiskAlertBlock(data: data['risk_flags']),
          const SizedBox(height: 16),
          BasicDetailsBlock(data: data['basic_details']),
          const SizedBox(height: 16),
          EMDFeeDetailsBlock(data: data['emd_fee_details']),
          const SizedBox(height: 16),
          WorkItemDetailsBlock(data: data['work_item_details']),
          const SizedBox(height: 16),
          CriticalDatesBlock(data: data['critical_dates']),
          const SizedBox(height: 16),
          TenderDocumentsBlock(data: data['tender_documents']),
          const SizedBox(height: 16),
          FinancialRequirementsBlock(data: data['financial_requirements']),
          const SizedBox(height: 16),
          LegalTermsBlock(data: data['legal_terms']),
          const SizedBox(height: 16),
          PostAwardBlock(data: data['post_award']),
        ],
      ),
    );
  }
}

class OverviewBlock extends StatelessWidget {
  final Map<String, dynamic> data;
  const OverviewBlock({required this.data, super.key});

  @override
  Widget build(BuildContext context) {
    return _blockCard(
      title: 'Overview',
      children: [
        Wrap(
          spacing: 8,
          children: List<Widget>.from(
            (data['tags'] as List).map((tag) => Chip(label: Text(tag))),
          ),
        ),
        const SizedBox(height: 8),
        _infoRow('Location', data['location']),
        _infoRow('Opening Date', data['opening_date']),
        _infoRow('Closing Date', data['closing_date']),
        _infoRow('Tender Amount', data['amount']),
        _infoRow('Tender Type', data['type']),
        _infoRow('Official Portal', data['portal_url']),
      ],
    );
  }
}

class AIRecommendationBlock extends StatelessWidget {
  final Map<String, dynamic> data;
  const AIRecommendationBlock({required this.data, super.key});

  @override
  Widget build(BuildContext context) {
    return _blockCard(
      title: 'AI Recommendation for You',
      children: [
        _infoRow('Fit Score', '${data['fit_score']}%'),
        _infoRow('Matching Summary', data['matching_summary']),
        ExpansionTile(
          title: const Text("Unmatched Criteria Summary"),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(data['unmatched_summary']),
            ),
          ],
        ),
        const SizedBox(height: 8),
        const Text(
          "Opportunity Highlights:",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 6),
        ...List<Widget>.from(
          (data['highlights'] as List).map(
            (e) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                children: [
                  const Icon(
                    Icons.check_circle_outline,
                    size: 16,
                    color: Colors.green,
                  ),
                  const SizedBox(width: 6),
                  Expanded(child: Text(e)),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class RiskAlertBlock extends StatelessWidget {
  final Map<String, dynamic> data;
  const RiskAlertBlock({required this.data, super.key});

  @override
  Widget build(BuildContext context) {
    return _blockCard(
      title: 'Risk & Alert Flags',
      children: [
        _alertRow("Red Flag", data['red'], Colors.red),
        _alertRow("Orange Flag", data['orange'], Colors.orange),
        _alertRow("Yellow Flag", data['yellow'], Colors.amber),
      ],
    );
  }
}

Widget _blockCard({required String title, required List<Widget> children}) {
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    elevation: 2,
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          ...children,
        ],
      ),
    ),
  );
}

Widget _infoRow(String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 120,
          child: Text(
            "$label:",
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
        Expanded(child: Text(value)),
      ],
    ),
  );
}

Widget _alertRow(String label, String desc, Color color) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.warning_amber_rounded, color: color),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(fontWeight: FontWeight.bold, color: color),
              ),
              Text(desc),
            ],
          ),
        ),
      ],
    ),
  );
}

class BasicDetailsBlock extends StatelessWidget {
  final Map<String, dynamic> data;
  const BasicDetailsBlock({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return _blockCard(
      title: 'Basic Details',
      children: [
        _infoRow('Organization Chain', data['organization_chain']),
        _infoRow('Tender Reference Number', data['tender_reference_number']),
        _infoRow('Tender ID', data['tender_id']),
        _infoRow(
          'Evaluation Allowed',
          data['evaluation_allowed'] ? 'Yes' : 'No',
        ),
        _infoRow('Payment Mode', data['payment_mode']),
        _infoRow(
          'Multi Currency Allowed',
          data['multi_currency'] ? 'Yes' : 'No',
        ),
        _infoRow(
          'Withdrawal Allowed',
          data['withdrawal_allowed'] ? 'Yes' : 'No',
        ),
        _infoRow('Form of Contract', data['form_of_contract']),
        _infoRow('No. of Covers', data['no_of_covers'].toString()),
        _infoRow('Inviting Authority Name', data['inviting_authority_name']),
        _infoRow(
          'Inviting Authority Address',
          data['inviting_authority_address'],
        ),
      ],
    );
  }
}

class EMDFeeDetailsBlock extends StatelessWidget {
  final Map<String, dynamic> data;
  const EMDFeeDetailsBlock({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return _blockCard(
      title: 'EMD Fee Details',
      children: [
        _infoRow('EMD Amount', data['amount']),
        _infoRow('EMD Fee Type', data['fee_type']),
        _infoRow('Payable To', data['payable_to']),
        _infoRow('Payable At', data['payable_at']),
      ],
    );
  }
}

class WorkItemDetailsBlock extends StatelessWidget {
  final Map<String, dynamic> data;
  const WorkItemDetailsBlock({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return _blockCard(
      title: 'Work Item Details',
      children: [
        _infoRow('Title', data['title']),
        _infoRow('Description', data['description']),
        _infoRow('NDA / Pre-Qualification', data['nda_prequalification']),
        _infoRow('Remarks', data['remarks']),
        _infoRow('Tender Value', data['tender_value']),
        _infoRow('Product Category', data['product_category']),
      ],
    );
  }
}

class CriticalDatesBlock extends StatelessWidget {
  final List<dynamic> data;
  const CriticalDatesBlock({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return _blockCard(
      title: 'Critical Dates',
      children: [
        Table(
          columnWidths: const {
            0: FlexColumnWidth(2),
            1: FlexColumnWidth(1.5),
            2: FlexColumnWidth(1.2),
          },
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: [
            // Table Header
            const TableRow(
              decoration: BoxDecoration(color: Color(0xFFE0E0E0)),
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                  child: Text(
                    "Event",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                  child: Text(
                    "Key Date",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                  child: Text(
                    "Days Left",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            ...data.map<TableRow>((item) {
              return TableRow(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Color(0xFFE0E0E0), width: 0.5),
                  ),
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 8,
                    ),
                    child: Text(item['event']),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 8,
                    ),
                    child: Text(item['key_date']),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 8,
                    ),
                    child: Text(
                      "${item['days_left']} days left",
                      style: const TextStyle(color: Colors.orange),
                    ),
                  ),
                ],
              );
            }).toList(),
          ],
        ),
        const SizedBox(height: 12), // bottom padding from next block
      ],
    );
  }
}

class TenderDocumentsBlock extends StatelessWidget {
  final List<dynamic> data;
  const TenderDocumentsBlock({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return _blockCard(
      title: 'Tender Documents',
      children:
          data.map((doc) {
            return ListTile(
              dense: true,
              title: Text(doc['name']),
              subtitle: Text(doc['size']),
              trailing: IconButton(
                icon: const Icon(Icons.download),
                onPressed: () async {
                  final url = Uri.parse(doc['url']);
                  if (await canLaunchUrl(url)) {
                    await launchUrl(url);
                  }
                },
              ),
            );
          }).toList(),
    );
  }
}

class FinancialRequirementsBlock extends StatelessWidget {
  final Map<String, dynamic> data;
  const FinancialRequirementsBlock({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final cost = data['cost_breakdown'];
    final perf = data['performance_guarantee'];

    return _blockCard(
      title: 'Financial Requirements & Commitments',
      children: [
        _infoRow('Estimated Contract Value', data['estimated_value']),
        _infoRow('Base Scope', cost['base_scope']),
        _infoRow('Taxes', cost['taxes']),
        _infoRow('Other Charges', cost['other_charges']),
        _infoRow('Bid Security Amount', data['bid_security_amount']),
        _infoRow('Bid Security Validity', data['bid_security_validity']),
        _infoRow(
          'Bid Security Formats',
          (data['bid_security_format'] as List).join(', '),
        ),
        _infoRow('Document Fee', data['document_fee_amount']),
        _infoRow('Document Fee Mode', data['document_fee_mode']),
        _infoRow(
          'Performance Guarantee',
          '${perf['percentage']} (${perf['value']})',
        ),
        _infoRow('Guarantee Triggers', data['guarantee_triggers']),
        _infoRow('Advance Payment Terms', data['advance_payment_terms']),
        _infoRow('Tax & Duty Clauses', data['tax_clauses']),
      ],
    );
  }
}

class EligibilityCriteriaBlock extends StatelessWidget {
  final Map<String, dynamic> data;
  const EligibilityCriteriaBlock({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final exp = data['experience_requirements'];
    final jv = data['jv_rules'];
    return _blockCard(
      title: 'Eligibility & Qualification Criteria',
      children: [
        _infoRow('Minimum Turnover', data['min_turnover']),
        _infoRow('Similar Contracts', exp['similar_contracts'].toString()),
        _infoRow('Minimum Value/Contract', exp['min_value_per_contract']),
        _infoRow('Similar Work Definition', data['definition_similar_work']),
        _infoRow('Min Quantity Benchmark', data['min_quantity_benchmark']),
        _infoRow('Key Personnel', data['key_personnel']),
        _infoRow(
          'Equipment Required',
          (data['equipment_requirements'] as List).join(', '),
        ),
        _infoRow(
          'Site Visit Required',
          data['site_visit_required'] ? 'Yes' : 'No',
        ),
        _infoRow('JV Allowed', jv['allowed'] ? 'Yes' : 'No'),
        _infoRow('Min JV Share', jv['minimum_share']),
        _infoRow('Litigation History', data['litigation_blacklist']),
        _infoRow('Financial Evidence', data['financial_evidence']),
        _infoRow('Misc', data['misc']),
      ],
    );
  }
}

class SubmissionInstructionsBlock extends StatelessWidget {
  final Map<String, dynamic> data;
  const SubmissionInstructionsBlock({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return _blockCard(
      title: 'Submission Instructions & Formats',
      children: [
        _infoRow('Submission Mode', data['submission_mode']),
        _infoRow(
          'Bid Envelope Structure',
          (data['bid_structure'] as List).join(', '),
        ),
        _infoRow(
          'Allowed File Formats',
          (data['file_formats'] as List).join(', '),
        ),
        _infoRow(
          'Digital Signature Required',
          data['digital_signature_required'] ? 'Yes' : 'No',
        ),
        _infoRow('Physical Address', data['physical_address']),
        _infoRow('No. of Copies', data['number_of_copies']),
        _infoRow('Checklist', (data['document_checklist'] as List).join(', ')),
        _infoRow('Security Clause', data['security_clause']),
        _infoRow('Misc', data['misc']),
      ],
    );
  }
}

class EvaluationAwardBlock extends StatelessWidget {
  final Map<String, dynamic> data;
  const EvaluationAwardBlock({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final weights = data['weightages'];
    return _blockCard(
      title: 'Evaluation & Award Process',
      children: [
        _infoRow('Evaluation Method', data['method']),
        _infoRow('Technical Weightage', weights['technical']),
        _infoRow('Financial Weightage', weights['financial']),
        _infoRow('Responsiveness Criteria', data['responsiveness']),
        _infoRow('Arithmetic Rules', data['arithmetic_rules']),
        _infoRow('Bid Capacity Rule', data['bid_capacity']),
        _infoRow('Negotiation', data['negotiation']),
        _infoRow('Award Rule', data['award_rules']),
        _infoRow('Notification Timeline', data['notification_timeline']),
        _infoRow('Misc', data['misc']),
      ],
    );
  }
}

class LegalTermsBlock extends StatelessWidget {
  final Map<String, dynamic> data;
  const LegalTermsBlock({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return _blockCard(
      title: 'Contractual & Legal Terms',
      children: [
        _infoRow('Form of Contract / Agreement', data['form_of_contract']),
        _infoRow('Performance Guarantee Release', data['performance_release']),
        _infoRow('Penalty Clauses', data['penalties']),
        _infoRow('Forfeiture Conditions', data['forfeiture_conditions']),
        _infoRow('Force Majeure', data['force_majeure']),
        _infoRow('Dispute Resolution', data['dispute_resolution']),
        _infoRow('Anti-Corruption Pact', data['anti_corruption']),
        _infoRow('Termination Clauses', data['termination_clauses']),
        _infoRow('Misc', data['misc']),
      ],
    );
  }
}

class PostAwardBlock extends StatelessWidget {
  final Map<String, dynamic> data;
  const PostAwardBlock({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return _blockCard(
      title: 'Post-Award Execution & Reporting',
      children: [
        _infoRow('Advance Payment Schedule', data['advance_schedule']),
        _infoRow('Progress Reporting', data['progress_reporting']),
        _infoRow('Quality Control & Testing', data['quality_control']),
        _infoRow('Milestone-Based Payments', data['milestones_payment']),
        _infoRow('Warranty / Defect Liability', data['warranty_period']),
        _infoRow('Final Handover Date', data['handover_date']),
        _infoRow('Misc', data['misc']),
      ],
    );
  }
}
