import 'package:flutter/material.dart';
import 'package:tenderiq_frontend/blocks/widget.dart';
import 'package:tenderiq_frontend/components/chatbot.dart';
import '../generated/default_connector/default.dart';

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
  }

  Future<GetTenderDetailsTender?> _fetchTenderDetails() async {
    final builder = DefaultConnector.instance.getTenderDetails(
      tenderId: widget.tenderId,
    );
    final result = await builder.execute();
    return result.data.tender;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<GetTenderDetailsTender?>(
      future: _futureTender,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
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
                Expanded(flex: 2, child: TenderInfoBlocks()),

                const SizedBox(width: 20),

                // Right chatbot panel
                Expanded(child: Chatbot()),
              ],
            ),
          ),
        );
      },
    );
  }
}
