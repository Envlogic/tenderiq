import 'package:flutter/material.dart';
import '../components/tendercard.dart';
import '../generated/default_connector/default.dart';
import '../screens/tender_detail.dart';

class DiscoverSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onChanged;
  final VoidCallback onDiscoverPressed;

  const DiscoverSearchBar({
    super.key,
    required this.controller,
    required this.onChanged,
    required this.onDiscoverPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          const Icon(Icons.search, color: Colors.grey),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(
                hintText: 'AI Powered Search',
                border: InputBorder.none,
              ),
              onChanged: onChanged,
            ),
          ),
          TextButton.icon(
            onPressed: onDiscoverPressed,
            icon: const Icon(Icons.auto_awesome, size: 18),
            label: const Text("Discover"),
            style: TextButton.styleFrom(
              backgroundColor: Colors.blue.shade100,
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DiscoverResults extends StatelessWidget {
  final List<TenderCard> tenders;

  const DiscoverResults({super.key, required this.tenders});

  @override
  Widget build(BuildContext context) {
    if (tenders.isEmpty) {
      return const Center(
        child: Text(
          "No tenders found.",
          style: TextStyle(color: Colors.black54),
        ),
      );
    }

    return ListView.separated(
      itemCount: tenders.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (context, index) => tenders[index],
    );
  }
}

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  late Future<List<GetAllTendersTenders>> _futureTenders;
  List<GetAllTendersTenders> _allTenders = [];

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
  void initState() {
    super.initState();
    _futureTenders = _fetchAllTenders();
  }

  Future<List<GetAllTendersTenders>> _fetchAllTenders() async {
    final builder = DefaultConnector.instance.getAllTenders();
    final result = await builder.execute();
    _allTenders = result.data.tenders;
    return _allTenders;
  }

  List<TenderCard> _filteredTenderCards() {
    final tenders =
        _searchQuery.isEmpty
            ? _allTenders
            : _allTenders
                .where(
                  (tender) => (tender.title ?? '').toLowerCase().contains(
                    _searchQuery.toLowerCase(),
                  ),
                )
                .toList();
    return tenders
        .map(
          (tender) => TenderCard(
            title: tender.title ?? 'No Title',
            categories: tender.tags ?? [],
            location: tender.location ?? '',
            description: tender.workItemDetail?.description ?? '',
            closingDate: tender.closingDate?.toString() ?? '',
            amount:
                tender.tenderAmount != null
                    ? '₹ \\${tender.tenderAmount!.toStringAsFixed(2)}'
                    : '',
            isFollowing: false,
            onFollowPressed: null,
            onTap:
                () => _openTenderDetail(
                  context,
                  tender.id,
                  tender.title ?? 'No Title',
                ),
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Center(
      child: SizedBox(
        width: screenWidth * 0.7,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DiscoverSearchBar(
                controller: _searchController,
                onChanged: (value) => setState(() => _searchQuery = value),
                onDiscoverPressed: () => debugPrint("AI Search Triggered"),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: FutureBuilder<List<GetAllTendersTenders>>(
                  future: _futureTenders,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: \\${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text('No tenders found.'));
                    }
                    // Update _allTenders if not already set
                    if (_allTenders.isEmpty) _allTenders = snapshot.data!;
                    return DiscoverResults(tenders: _filteredTenderCards());
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
