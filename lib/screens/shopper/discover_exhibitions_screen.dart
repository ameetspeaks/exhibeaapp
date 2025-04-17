import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DiscoverExhibitionsScreen extends StatefulWidget {
  const DiscoverExhibitionsScreen({super.key});

  @override
  State<DiscoverExhibitionsScreen> createState() => _DiscoverExhibitionsScreenState();
}

class _DiscoverExhibitionsScreenState extends State<DiscoverExhibitionsScreen> {
  final _searchController = TextEditingController();
  bool _isLoading = true;
  final List<Map<String, dynamic>> _exhibitions = [];
  String _selectedCategory = 'All';

  @override
  void initState() {
    super.initState();
    _loadExhibitions();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadExhibitions() async {
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));
      
      setState(() {
        _exhibitions.addAll([
          {
            'id': '1',
            'title': 'Tech Expo 2024',
            'description': 'The biggest technology exhibition of the year',
            'date': '2024-07-15',
            'location': 'Convention Center',
            'imageUrl': 'https://example.com/tech-expo.jpg',
          },
          {
            'id': '2',
            'title': 'Fashion Week',
            'description': 'Celebrating the latest trends in fashion',
            'date': '2024-08-20',
            'location': 'Fashion District',
            'imageUrl': 'https://example.com/fashion-week.jpg',
          },
        ]);
        _isLoading = false;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load exhibitions: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Discover Exhibitions'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _exhibitions.length,
              itemBuilder: (context, index) {
                final exhibition = _exhibitions[index];
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AspectRatio(
                        aspectRatio: 16 / 9,
                        child: Image.network(
                          exhibition['imageUrl'],
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Center(
                              child: Icon(Icons.error),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              exhibition['title'],
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              exhibition['description'],
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Date: ${exhibition['date']}',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Location: ${exhibition['location']}',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }

  Widget _buildCategoryChip(String category) {
    final isSelected = _selectedCategory == category;
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: FilterChip(
        label: Text(category),
        selected: isSelected,
        onSelected: (selected) {
          setState(() {
            _selectedCategory = selected ? category : 'All';
          });
          // TODO: Implement category filtering
        },
      ),
    );
  }
} 