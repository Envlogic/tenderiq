import 'package:flutter/material.dart';
import '../generated/default_connector/default.dart';
import 'tendercard.dart';
import '../screens/tender_detail.dart';

class WatchList extends StatefulWidget {
  const WatchList({super.key});

  @override
  State<WatchList> createState() => _WatchListState();
}

class _WatchListState extends State<WatchList> {
  late Future<List<GetWatchlistTendersTenders>> _futureWatchlist;

  @override
  void initState() {
    super.initState();
    _futureWatchlist = _fetchWatchlistTenders();
  }

  Future<List<GetWatchlistTendersTenders>> _fetchWatchlistTenders() async {
    final builder = DefaultConnector.instance.getWatchlistTenders();
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
    return FutureBuilder<List<GetWatchlistTendersTenders>>(
      future: _futureWatchlist,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: \\${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No tenders in your watch list.'));
        }
        final tenders = snapshot.data!;
        return ListView.builder(
          padding: const EdgeInsets.only(bottom: 16),
          itemCount: tenders.length,
          itemBuilder: (context, index) {
            final tender = tenders[index];
            return TenderCard(
              title: tender.title ?? 'No Title',
              categories: tender.tags ?? [],
              location: tender.location ?? '',
              description: tender.workItemDetail?.description ?? '',
              closingDate: tender.closingDate?.toString() ?? '',
              amount:
                  tender.tenderAmount != null
                      ? '₹ \\${tender.tenderAmount!.toStringAsFixed(2)}'
                      : '',
              isFollowing: true, // Since it's in the watchlist
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
