import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SavedItemsScreen extends StatefulWidget {
  const SavedItemsScreen({super.key});

  @override
  State<SavedItemsScreen> createState() => _SavedItemsScreenState();
}

class _SavedItemsScreenState extends State<SavedItemsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isLoading = false;
  List<Map<String, dynamic>> _savedExhibitions = [];
  List<Map<String, dynamic>> _savedBrands = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadSavedItems();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadSavedItems() async {
    setState(() => _isLoading = true);
    try {
      // Simulated API calls
      await Future.delayed(const Duration(seconds: 1));
      setState(() {
        _savedExhibitions = [
          {
            'id': '1',
            'name': 'Fashion Week 2024',
            'date': 'March 15-20, 2024',
            'image': 'https://picsum.photos/400/300?random=1',
          },
          {
            'id': '2',
            'name': 'Tech Expo 2024',
            'date': 'April 5-7, 2024',
            'image': 'https://picsum.photos/400/300?random=2',
          },
        ];
        _savedBrands = [
          {
            'id': '1',
            'name': 'Fashion Forward',
            'category': 'Clothing',
            'image': 'https://picsum.photos/400/300?random=3',
          },
          {
            'id': '2',
            'name': 'Tech Innovations',
            'category': 'Electronics',
            'image': 'https://picsum.photos/400/300?random=4',
          },
        ];
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load saved items: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _unsaveExhibition(String exhibitionId) async {
    setState(() {
      _savedExhibitions.removeWhere((exhibition) => exhibition['id'] == exhibitionId);
    });

    // Simulated API call
    await Future.delayed(const Duration(milliseconds: 500));
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Exhibition unsaved')),
      );
    }
  }

  Future<void> _unsaveBrand(String brandId) async {
    setState(() {
      _savedBrands.removeWhere((brand) => brand['id'] == brandId);
    });

    // Simulated API call
    await Future.delayed(const Duration(milliseconds: 500));
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Brand unsaved')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Items'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Exhibitions'),
            Tab(text: 'Brands'),
          ],
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : TabBarView(
              controller: _tabController,
              children: [
                _buildExhibitionsList(),
                _buildBrandsList(),
              ],
            ),
    );
  }

  Widget _buildExhibitionsList() {
    if (_savedExhibitions.isEmpty) {
      return const Center(
        child: Text('No saved exhibitions yet'),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _savedExhibitions.length,
      itemBuilder: (context, index) {
        final exhibition = _savedExhibitions[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          child: InkWell(
            onTap: () => context.go('/shopper/exhibitions/${exhibition['id']}'),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    exhibition['image'],
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        exhibition['name'],
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        exhibition['date'],
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.favorite),
                  color: Colors.red,
                  onPressed: () => _unsaveExhibition(exhibition['id']),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildBrandsList() {
    if (_savedBrands.isEmpty) {
      return const Center(
        child: Text('No saved brands yet'),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _savedBrands.length,
      itemBuilder: (context, index) {
        final brand = _savedBrands[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          child: InkWell(
            onTap: () => context.go('/shopper/brands/${brand['id']}'),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    brand['image'],
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        brand['name'],
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        brand['category'],
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.favorite),
                  color: Colors.red,
                  onPressed: () => _unsaveBrand(brand['id']),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
} 