import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ShopperDashboardScreen extends StatelessWidget {
  const ShopperDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSection(
            context,
            title: 'Featured Exhibitions',
            onSeeAll: () => context.push('/shopper/exhibitions'),
            child: const SizedBox(
              height: 200,
              child: Center(
                child: Text('Featured exhibitions will appear here'),
              ),
            ),
          ),
          const SizedBox(height: 24),
          _buildSection(
            context,
            title: 'Saved Items',
            onSeeAll: () => context.push('/shopper/saved'),
            child: const SizedBox(
              height: 200,
              child: Center(
                child: Text('Your saved items will appear here'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(
    BuildContext context, {
    required String title,
    required VoidCallback onSeeAll,
    required Widget child,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            TextButton(
              onPressed: onSeeAll,
              child: const Text('See All'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        child,
      ],
    );
  }
} 