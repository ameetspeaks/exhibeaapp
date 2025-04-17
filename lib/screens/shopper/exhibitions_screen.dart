import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ExhibitionsScreen extends StatefulWidget {
  const ExhibitionsScreen({super.key});

  @override
  State<ExhibitionsScreen> createState() => _ExhibitionsScreenState();
}

class _ExhibitionsScreenState extends State<ExhibitionsScreen> {
  bool _isLoading = false;
  List<Map<String, dynamic>> _exhibitions = [];
  List<Map<String, dynamic>> _filteredExhibitions = [];
  final TextEditingController _searchController = TextEditingController();
  final Set<String> _savedExhibitionIds = {};

  @override
  void initState() {
    super.initState();
    _loadExhibitions();
    _loadSavedExhibitions();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadSavedExhibitions() async {
    // Simulated API call to load saved exhibitions
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() {
      _savedExhibitionIds.add('1'); // Example: Fashion Week is saved
    });
  }

  Future<void> _loadExhibitions() async {
    setState(() => _isLoading = true);
    try {
      // Simulated API call
      await Future.delayed(const Duration(seconds: 1));
      setState(() {
        _exhibitions = [
          {
            'id': '1',
            'name': 'Fashion Week 2024',
            'date': 'March 15-20, 2024',
            'location': 'Convention Center',
            'image': 'https://picsum.photos/400/300?random=1',
          },
          {
            'id': '2',
            'name': 'Tech Expo 2024',
            'date': 'April 5-7, 2024',
            'location': 'Tech Hub',
            'image': 'https://picsum.photos/400/300?random=2',
          },
          {
            'id': '3',
            'name': 'Art & Design Fair',
            'date': 'May 10-12, 2024',
            'location': 'Art Gallery',
            'image': 'https://picsum.photos/400/300?random=3',
          },
        ];
        _filteredExhibitions = _exhibitions;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load exhibitions: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _filterExhibitions(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredExhibitions = _exhibitions;
      } else {
        _filteredExhibitions = _exhibitions.where((exhibition) {
          final name = exhibition['name'].toString().toLowerCase();
          final location = exhibition['location'].toString().toLowerCase();
          final searchQuery = query.toLowerCase();
          return name.contains(searchQuery) || location.contains(searchQuery);
        }).toList();
      }
    });
  }

  Future<void> _toggleSaveExhibition(String exhibitionId) async {
    setState(() {
      if (_savedExhibitionIds.contains(exhibitionId)) {
        _savedExhibitionIds.remove(exhibitionId);
      } else {
        _savedExhibitionIds.add(exhibitionId);
      }
    });

    // Simulated API call to save/unsave
    await Future.delayed(const Duration(milliseconds: 500));
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _savedExhibitionIds.contains(exhibitionId)
                ? 'Exhibition saved'
                : 'Exhibition unsaved',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exhibitions'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: ExhibitionSearchDelegate(_exhibitions),
              );
            },
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search exhibitions...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onChanged: _filterExhibitions,
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _filteredExhibitions.length,
                    itemBuilder: (context, index) {
                      final exhibition = _filteredExhibitions[index];
                      final isSaved = _savedExhibitionIds.contains(exhibition['id']);
                      return Card(
                        margin: const EdgeInsets.only(bottom: 16),
                        child: InkWell(
                          onTap: () => context.go('/shopper/exhibitions/${exhibition['id']}'),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Stack(
                                children: [
                                  Image.network(
                                    exhibition['image'],
                                    height: 200,
                                    fit: BoxFit.cover,
                                  ),
                                  Positioned(
                                    top: 8,
                                    right: 8,
                                    child: IconButton(
                                      icon: Icon(
                                        isSaved ? Icons.favorite : Icons.favorite_border,
                                        color: isSaved ? Colors.red : Colors.white,
                                      ),
                                      onPressed: () => _toggleSaveExhibition(exhibition['id']),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      exhibition['name'],
                                      style: Theme.of(context).textTheme.titleLarge,
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        const Icon(Icons.calendar_today, size: 16),
                                        const SizedBox(width: 8),
                                        Text(exhibition['date']),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        const Icon(Icons.location_on, size: 16),
                                        const SizedBox(width: 8),
                                        Text(exhibition['location']),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}

class ExhibitionSearchDelegate extends SearchDelegate {
  final List<Map<String, dynamic>> exhibitions;

  ExhibitionSearchDelegate(this.exhibitions);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = exhibitions.where((exhibition) {
      final name = exhibition['name'].toString().toLowerCase();
      final location = exhibition['location'].toString().toLowerCase();
      final searchQuery = query.toLowerCase();
      return name.contains(searchQuery) || location.contains(searchQuery);
    }).toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final exhibition = results[index];
        return ListTile(
          title: Text(exhibition['name']),
          subtitle: Text(exhibition['location']),
          onTap: () {
            context.go('/shopper/exhibitions/${exhibition['id']}');
            close(context, null);
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = exhibitions.where((exhibition) {
      final name = exhibition['name'].toString().toLowerCase();
      final location = exhibition['location'].toString().toLowerCase();
      final searchQuery = query.toLowerCase();
      return name.contains(searchQuery) || location.contains(searchQuery);
    }).toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final exhibition = suggestions[index];
        return ListTile(
          title: Text(exhibition['name']),
          subtitle: Text(exhibition['location']),
          onTap: () {
            context.go('/shopper/exhibitions/${exhibition['id']}');
            close(context, null);
          },
        );
      },
    );
  }
} 