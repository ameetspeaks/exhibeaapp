import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../utils/placeholder_image.dart';

class BrowseExhibitionsScreen extends StatefulWidget {
  const BrowseExhibitionsScreen({super.key});

  @override
  State<BrowseExhibitionsScreen> createState() => _BrowseExhibitionsScreenState();
}

class _BrowseExhibitionsScreenState extends State<BrowseExhibitionsScreen> {
  final _searchController = TextEditingController();
  bool _isLoading = false;
  List<Map<String, dynamic>> _exhibitions = [];

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
    setState(() => _isLoading = true);

    try {
      // TODO: Implement exhibition loading logic
      await Future.delayed(const Duration(seconds: 1)); // Simulated API call
      setState(() {
        _exhibitions = [
          {
            'id': '1',
            'title': 'Tech Expo 2024',
            'description': 'The largest technology exhibition in the region',
            'date': 'March 15-17, 2024',
            'location': 'Convention Center, City',
            'image': 'assets/images/exhibition_placeholder.jpg',
            'availableStalls': 5,
          },
          {
            'id': '2',
            'title': 'Fashion Week',
            'description': 'Annual fashion exhibition showcasing latest trends',
            'date': 'April 1-7, 2024',
            'location': 'Exhibition Hall, City',
            'image': 'assets/images/exhibition_placeholder.jpg',
            'availableStalls': 3,
          },
        ];
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading exhibitions: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Browse Exhibitions'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search exhibitions...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onChanged: (value) {
                // TODO: Implement search functionality
              },
            ),
          ),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    padding: const EdgeInsets.all(16.0),
                    itemCount: _exhibitions.length,
                    itemBuilder: (context, index) {
                      final exhibition = _exhibitions[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 16),
                        child: InkWell(
                          onTap: () => context.go('/brand/exhibitions/${exhibition['id']}'),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  const PlaceholderImage(
                                    height: 200,
                                    backgroundColor: Colors.grey,
                                    icon: Icons.explore,
                                    iconColor: Colors.white,
                                  ),
                                  Positioned(
                                    bottom: 8,
                                    right: 8,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.7),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Text(
                                        '${exhibition['availableStalls']} stalls available',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      exhibition['title'],
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(exhibition['description']),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        const Icon(Icons.calendar_today, size: 16),
                                        const SizedBox(width: 4),
                                        Expanded(
                                          child: Text(
                                            exhibition['date'],
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        const SizedBox(width: 16),
                                        const Icon(Icons.location_on, size: 16),
                                        const SizedBox(width: 4),
                                        Expanded(
                                          child: Text(
                                            exhibition['location'],
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 16),
                                    SizedBox(
                                      width: double.infinity,
                                      child: ElevatedButton(
                                        onPressed: () => context.go('/brand/exhibitions/${exhibition['id']}'),
                                        child: const Text('View Details'),
                                      ),
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