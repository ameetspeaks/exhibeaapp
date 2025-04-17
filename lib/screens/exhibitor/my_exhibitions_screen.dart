import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MyExhibitionsScreen extends StatefulWidget {
  const MyExhibitionsScreen({super.key});

  @override
  State<MyExhibitionsScreen> createState() => _MyExhibitionsScreenState();
}

class _MyExhibitionsScreenState extends State<MyExhibitionsScreen> {
  bool _isLoading = true;
  List<Map<String, dynamic>> _exhibitions = [];

  @override
  void initState() {
    super.initState();
    _loadExhibitions();
  }

  Future<void> _loadExhibitions() async {
    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));
    
    setState(() {
      _exhibitions = [
        {
          'id': '1',
          'name': 'Tech Expo 2024',
          'date': '2024-03-15',
          'location': 'New York',
          'status': 'active',
          'imageUrl': 'https://example.com/tech-expo.jpg',
        },
        {
          'id': '2',
          'name': 'Fashion Week',
          'date': '2024-04-20',
          'location': 'Los Angeles',
          'status': 'upcoming',
          'imageUrl': 'https://example.com/fashion-week.jpg',
        },
        {
          'id': '3',
          'name': 'Food Festival',
          'date': '2024-05-10',
          'location': 'Chicago',
          'status': 'draft',
          'imageUrl': 'https://example.com/food-festival.jpg',
        },
      ];
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Exhibitions'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push('/exhibitor/exhibitions/new'),
          ),
        ],
      ),
      body: _exhibitions.isEmpty
          ? const Center(
              child: Text('No exhibitions found. Create your first exhibition!'),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _exhibitions.length,
              itemBuilder: (context, index) {
                final exhibition = _exhibitions[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: InkWell(
                    onTap: () => context.push('/exhibitor/exhibitions/${exhibition['id']}'),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AspectRatio(
                          aspectRatio: 16 / 9,
                          child: Image.network(
                            exhibition['imageUrl'],
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: Colors.grey[200],
                                child: const Icon(Icons.image, size: 50),
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      exhibition['name'],
                                      style: Theme.of(context).textTheme.titleLarge,
                                    ),
                                  ),
                                  Chip(
                                    label: Text(exhibition['status']),
                                    backgroundColor: _getStatusColor(exhibition['status']).withOpacity(0.2),
                                    labelStyle: TextStyle(
                                      color: _getStatusColor(exhibition['status']),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  const Icon(Icons.calendar_today, size: 16),
                                  const SizedBox(width: 4),
                                  Text(exhibition['date']),
                                  const SizedBox(width: 16),
                                  const Icon(Icons.location_on, size: 16),
                                  const SizedBox(width: 4),
                                  Text(exhibition['location']),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                    onPressed: () => context.push('/exhibitor/exhibitions/${exhibition['id']}/edit'),
                                    child: const Text('Edit'),
                                  ),
                                  const SizedBox(width: 8),
                                  TextButton(
                                    onPressed: () => context.push('/exhibitor/exhibitions/${exhibition['id']}/bookings'),
                                    child: const Text('View Bookings'),
                                  ),
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
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'active':
        return Colors.green;
      case 'upcoming':
        return Colors.orange;
      case 'draft':
        return Colors.grey;
      default:
        return Colors.grey;
    }
  }
} 