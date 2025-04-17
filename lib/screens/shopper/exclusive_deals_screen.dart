import 'package:flutter/material.dart';

class ExclusiveDealsScreen extends StatefulWidget {
  const ExclusiveDealsScreen({super.key});

  @override
  State<ExclusiveDealsScreen> createState() => _ExclusiveDealsScreenState();
}

class _ExclusiveDealsScreenState extends State<ExclusiveDealsScreen> {
  bool _isLoading = true;
  final List<Map<String, dynamic>> _deals = [];

  @override
  void initState() {
    super.initState();
    _loadDeals();
  }

  Future<void> _loadDeals() async {
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));
      
      // Sample data
      setState(() {
        _deals.addAll([
          {
            'id': '1',
            'title': 'Summer Collection Sale',
            'brand': 'Fashion House',
            'discount': '50%',
            'validUntil': '2024-08-31',
            'imageUrl': 'https://example.com/summer-sale.jpg',
          },
          {
            'id': '2',
            'title': 'Tech Week Special',
            'brand': 'Tech Gadgets',
            'discount': '30%',
            'validUntil': '2024-07-15',
            'imageUrl': 'https://example.com/tech-sale.jpg',
          },
        ]);
        _isLoading = false;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load deals: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exclusive Deals'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _deals.length,
              itemBuilder: (context, index) {
                final deal = _deals[index];
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AspectRatio(
                        aspectRatio: 16 / 9,
                        child: Image.network(
                          deal['imageUrl'],
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
                              deal['title'],
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Brand: ${deal['brand']}',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Discount: ${deal['discount']}',
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: Theme.of(context).colorScheme.primary,
                                  ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Valid until: ${deal['validUntil']}',
                              style: Theme.of(context).textTheme.bodySmall,
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
} 