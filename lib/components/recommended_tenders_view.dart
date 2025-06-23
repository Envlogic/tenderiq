import 'package:flutter/material.dart';
import '../generated/default_connector/default.dart';
import 'tendercard.dart';
import '../screens/tender_detail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RecommendedTendersView extends StatefulWidget {
  const RecommendedTendersView({super.key});

  @override
  State<RecommendedTendersView> createState() => _RecommendedTendersViewState();
}

class _RecommendedTendersViewState extends State<RecommendedTendersView> {
  late Future<List<GetRecommendedTendersTenders>> _futureTenders;

  @override
  void initState() {
    super.initState();
    _futureTenders = _fetchRecommendedTenders();
  }

  Future<List<GetRecommendedTendersTenders>> _fetchRecommendedTenders() async {
    final builder = DefaultConnector.instance.getRecommendedTenders();
    final result = await builder.execute();
    return result.data.tenders;
  }

  void _openTenderDetail(
    BuildContext context,
    String tenderId,
    String tenderTitle,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (_) => TenderDetail(tenderId: tenderId, tenderTitle: tenderTitle),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<GetRecommendedTendersTenders>>(
      future: _futureTenders,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No recommended tenders found.'));
        }

        final tenders = snapshot.data!;
        return ListView.builder(
          itemCount: tenders.length,
          itemBuilder: (context, index) {
            final tender = tenders[index];

            // Format closing date
            // Format closing date
            const String closingDateStr = '2025-07-10';

            return TenderCard(
              title: tender.title ?? 'No Title',
              categories: tender.tags ?? [],
              location: tender.location ?? '',
              description: tender.workItemDetail?.description ?? '',
              closingDate: closingDateStr,
              amount:
                  tender.tenderAmount != null
                      ? '₹ ${tender.tenderAmount!.toStringAsFixed(2)}'
                      : '',
              isFollowing: false, // Update if follow logic exists
              onFollowPressed: null,
              onTap:
                  () => _openTenderDetail(
                    context,
                    tender.id,
                    tender.title ?? 'No Title',
                  ),
            );
          },
        );
      },
    );
  }
}
