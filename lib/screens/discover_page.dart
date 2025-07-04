import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../components/tendercard.dart';
import '../generated/default_connector/default.dart';
import '../screens/tender_detail.dart';

class DiscoverSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onChanged;
  final VoidCallback onDiscoverPressed;
  final VoidCallback onFocus;
  final bool isLoading;

  const DiscoverSearchBar({
    super.key,
    required this.controller,
    required this.onChanged,
    required this.onDiscoverPressed,
    required this.onFocus,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
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
                child: Focus(
                  onFocusChange: (hasFocus) {
                    if (hasFocus) onFocus();
                  },
                  child: TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                      hintText: 'AI Powered Search',
                      border: InputBorder.none,
                    ),
                    onChanged: onChanged,
                  ),
                ),
              ),
              TextButton.icon(
                onPressed: onDiscoverPressed,
                icon: const Icon(Icons.auto_awesome, size: 18),
                label: const Text("Discover"),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blue.shade100,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
              ),
            ],
          ),
        ),
        if (isLoading)
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: LinearProgressIndicator(minHeight: 3),
          ),
      ],
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

  // AI search and suggestion state
  List<Map<String, dynamic>> _aiSearchResults = [];
  bool _isAiSearching = false;
  String? _aiSearchError;
  List<String> _aiSuggestions = [];
  bool _isAiSuggesting = false;
  String? _aiSuggestError;

  // New: AI Context variables
  Map<String, dynamic>? _aiSearchContext;
  Map<String, dynamic>? _aiSuggestionContext;

  // Use the same userId as in profile_page.dart
  static const String _userId = '6763ec20-b327-4b1a-8e55-fbc42b02c184';

  // Add this variable to track if suggestions have been triggered
  bool _suggestionTriggered = false;

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
    _fetchAISearchContext();
    _fetchAISuggestionContext();
  }

  Future<List<GetAllTendersTenders>> _fetchAllTenders() async {
    final builder = DefaultConnector.instance.getAllTenders();
    final result = await builder.execute();
    _allTenders = result.data.tenders;
    return _allTenders;
  }

  // Fetch GetAISearchContext data using FirebaseDataConnect
  Future<void> _fetchAISearchContext() async {
    // print('Calling _fetchAISearchContext');
    try {
      final builder =
          DefaultConnector.instance.getAiSearchContext(userId: _userId)
            ..limit(25)
            ..offset(0);
      final result = await builder.execute();
      setState(() {
        _aiSearchContext = result.data.toJson();
      });
      // Print to console
      // print('AISearchContext: ' + result.data.toJson().toString());
    } catch (e) {
      print('Error in _fetchAISearchContext: ' + e.toString());
    }
  }

  // Fetch GetAISuggestionContext data using FirebaseDataConnect
  Future<void> _fetchAISuggestionContext() async {
    // print('Calling _fetchAISuggestionContext');
    try {
      final builder = DefaultConnector.instance.getAiSuggestionContext(
        userId: _userId,
      );
      final result = await builder.execute();
      setState(() {
        _aiSuggestionContext = result.data.toJson();
      });
      // Print to console
      // print('AISuggestionContext: ' + result.data.toJson().toString());
    } catch (e) {
      print('Error in _fetchAISuggestionContext: ' + e.toString());
    }
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

  // ──────────────── AI SEARCH ────────────────
  Future<void> _performAiSearch() async {
    setState(() {
      _isAiSearching = true;
      _aiSearchError = null;
      _aiSearchResults = [];
    });
    try {
      if (_aiSearchContext == null) {
        _aiSearchError = "AI Search Context not loaded.";
        setState(() {
          _isAiSearching = false;
        });
        return;
      }
      final response = await http.post(
        Uri.parse(
          'https://us-central1-tenderiq-f763c.cloudfunctions.net/ai_search',
        ),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'aiSearchContext': _aiSearchContext,
          'query': _searchController.text,
        }),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body.trim());
        if (data is List) {
          _aiSearchResults = List<Map<String, dynamic>>.from(data);
        } else {
          _aiSearchResults = [];
        }
      } else {
        _aiSearchError = response.body;
      }
    } catch (e) {
      _aiSearchError = e.toString();
    }
    setState(() {
      _isAiSearching = false;
    });
  }

  // ──────────────── AI SUGGEST ────────────────
  Future<void> _fetchAiSuggestions() async {
    if (_isAiSuggesting) return;
    setState(() {
      _isAiSuggesting = true;
      _aiSuggestError = null;
      _aiSuggestions = [];
    });
    try {
      if (_aiSuggestionContext == null) {
        _aiSuggestError = "AI Suggestion Context not loaded.";
        setState(() {
          _isAiSuggesting = false;
        });
        return;
      }
      final response = await http.post(
        Uri.parse(
          'https://us-central1-tenderiq-f763c.cloudfunctions.net/ai_suggestion',
        ),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'aiSuggestionContext': _aiSuggestionContext}),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data is List) {
          _aiSuggestions = List<String>.from(data);
        } else {
          _aiSuggestions = [];
        }
      } else {
        _aiSuggestError = response.body;
      }
    } catch (e) {
      _aiSuggestError = e.toString();
    }
    setState(() {
      _isAiSuggesting = false;
    });
  }

  void _onSearchBarFocus() {
    if (!_suggestionTriggered) {
      _fetchAiSuggestions();
      _suggestionTriggered = true;
    }
  }

  void _onDiscoverPressed() {
    setState(() {
      _aiSuggestions = [];
      _suggestionTriggered = false;
    });
    _performAiSearch();
  }

  void _onSuggestionSelected(String suggestion) {
    setState(() {
      _searchController.text = '';
      _searchQuery = '';
    });
    // Use a post-frame callback to avoid TextEditingController issues
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _searchController.text = suggestion;
        _searchQuery = suggestion;
      });
    });
  }

  Widget _buildAiSuggestions() {
    if (_isAiSuggesting) {
      // Don't show anything here, progress is shown in search bar
      return const SizedBox(height: 8);
    }
    if (_aiSuggestError != null) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Text(
          'AI Suggestion Error: \\$_aiSuggestError',
          style: const TextStyle(color: Colors.red),
        ),
      );
    }
    if (_aiSuggestions.isEmpty) {
      return const SizedBox(height: 8);
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Wrap(
        spacing: 8,
        children:
            _aiSuggestions
                .map(
                  (s) => ActionChip(
                    label: Text(s),
                    avatar: const Icon(Icons.search, size: 18),
                    onPressed: () => _onSuggestionSelected(s),
                  ),
                )
                .toList(),
      ),
    );
  }

  Widget _buildAiSearchResults() {
    if (_isAiSearching) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_aiSearchError != null) {
      return Center(
        child: Text(
          'AI Search Error: \\$_aiSearchError',
          style: const TextStyle(color: Colors.red),
        ),
      );
    }
    if (_aiSearchResults.isEmpty) {
      return const Center(child: Text('No AI search results.'));
    }
    return ListView.separated(
      itemCount: _aiSearchResults.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        final tender = _aiSearchResults[index];
        return TenderCard(
          title: tender['title'] ?? 'No Title',
          categories: List<String>.from(tender['categories'] ?? []),
          location: tender['location'] ?? '',
          description: tender['description'] ?? '',
          closingDate: tender['closingDate'] ?? '',
          amount: tender['amount'] ?? '',
          isFollowing: false,
          onFollowPressed: null,
          onTap:
              () => _openTenderDetail(
                context,
                tender['id'] ?? '',
                tender['title'] ?? 'No Title',
              ),
        );
      },
    );
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
                onDiscoverPressed: _onDiscoverPressed,
                onFocus: _onSearchBarFocus,
                isLoading: _isAiSuggesting,
              ),
              _buildAiSuggestions(),
              const SizedBox(height: 20),
              Expanded(
                child:
                    _aiSearchResults.isNotEmpty ||
                            _isAiSearching ||
                            _aiSearchError != null
                        ? _buildAiSearchResults()
                        : FutureBuilder<List<GetAllTendersTenders>>(
                          future: _futureTenders,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (snapshot.hasError) {
                              return Center(
                                child: Text('Error: \\${snapshot.error}'),
                              );
                            } else if (!snapshot.hasData ||
                                snapshot.data!.isEmpty) {
                              return const Center(
                                child: Text('No tenders found.'),
                              );
                            }
                            if (_allTenders.isEmpty)
                              _allTenders = snapshot.data!;
                            return DiscoverResults(
                              tenders: _filteredTenderCards(),
                            );
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
