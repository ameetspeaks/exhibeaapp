import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Your Role'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildRoleCard(
              context,
              icon: Icons.event,
              title: 'Exhibitor',
              description: 'Create and manage exhibitions',
              onTap: () => context.go('/register?role=exhibitor'),
            ),
            const SizedBox(height: 16),
            _buildRoleCard(
              context,
              icon: Icons.store,
              title: 'Brand',
              description: 'Book stalls and showcase products',
              onTap: () => context.go('/register?role=brand'),
            ),
            const SizedBox(height: 16),
            _buildRoleCard(
              context,
              icon: Icons.shopping_bag,
              title: 'Shopper',
              description: 'Discover and visit exhibitions',
              onTap: () => context.go('/register?role=shopper'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoleCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String description,
    required VoidCallback onTap,
  }) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(icon, size: 40),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios),
            ],
          ),
        ),
      ),
    );
  }
} 