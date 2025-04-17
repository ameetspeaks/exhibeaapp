import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          floating: true,
          title: const Text('Welcome Back!'),
          actions: [
            IconButton(
              icon: const Icon(Icons.notifications_outlined),
              onPressed: () {
                // TODO: Implement notifications
              },
            ),
          ],
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Search Bar
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Search exhibitions, brands...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: theme.cardColor,
                  ),
                  onTap: () {
                    // TODO: Implement search
                  },
                ),
                const SizedBox(height: 24),
                
                // Featured Exhibitions
                Text(
                  'Featured Exhibitions',
                  style: theme.textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 200,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: _buildExhibitionCard(context, index),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 24),
                
                // Popular Brands
                Text(
                  'Popular Brands',
                  style: theme.textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return _buildBrandCard(context, index);
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildExhibitionCard(BuildContext context, int index) {
    final exhibitions = [
      {
        'name': 'Fashion Week 2024',
        'date': 'March 15-20, 2024',
        'image': 'https://picsum.photos/300/200?random=$index',
      },
      {
        'name': 'Tech Expo 2024',
        'date': 'April 5-7, 2024',
        'image': 'https://picsum.photos/300/200?random=${index + 10}',
      },
      {
        'name': 'Art & Design Fair',
        'date': 'May 10-12, 2024',
        'image': 'https://picsum.photos/300/200?random=${index + 20}',
      },
    ];

    final exhibition = exhibitions[index];
    
    return GestureDetector(
      onTap: () => context.go('/shopper/exhibitions/${index + 1}'),
      child: Container(
        width: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          image: DecorationImage(
            image: NetworkImage(exhibition['image'] as String),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Colors.black.withOpacity(0.7),
              ],
            ),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                exhibition['name'] as String,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                exhibition['date'] as String,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBrandCard(BuildContext context, int index) {
    final brands = [
      {
        'name': 'Fashion Forward',
        'category': 'Clothing',
        'image': 'https://picsum.photos/200/200?random=$index',
      },
      {
        'name': 'Tech Innovations',
        'category': 'Electronics',
        'image': 'https://picsum.photos/200/200?random=${index + 10}',
      },
      {
        'name': 'Artisan Crafts',
        'category': 'Handmade',
        'image': 'https://picsum.photos/200/200?random=${index + 20}',
      },
      {
        'name': 'Luxury Living',
        'category': 'Home Decor',
        'image': 'https://picsum.photos/200/200?random=${index + 30}',
      },
    ];

    final brand = brands[index];
    
    return GestureDetector(
      onTap: () => context.go('/shopper/brands/${index + 1}'),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.network(
                  brand['image'] as String,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    brand['name'] as String,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    brand['category'] as String,
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodySmall?.color,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
} 