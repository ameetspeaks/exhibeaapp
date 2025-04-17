import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../services/auth_service.dart';
import '../models/user_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoading = true;
  UserModel? _currentUser;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      final user = await AuthService().getCurrentUser();
      setState(() {
        _currentUser = user;
        _isLoading = false;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load user data: $e')),
        );
      }
    }
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
        title: Text('Welcome, ${_currentUser?.name ?? 'User'}'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_currentUser?.role == 'Organizer') ...[
              _buildSectionTitle('Your Exhibitions'),
              _buildOrganizerDashboard(),
            ] else if (_currentUser?.role == 'Brand') ...[
              _buildSectionTitle('Your Bookings'),
              _buildBrandDashboard(),
            ] else ...[
              _buildSectionTitle('Explore Exhibitions'),
              _buildShopperDashboard(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildOrganizerDashboard() {
    return Column(
      children: [
        _buildActionCard(
          'Create Exhibition',
          'Create a new exhibition and manage stalls',
          Icons.add_business,
          () => context.go('/organizer/create-exhibition'),
        ),
        const SizedBox(height: 16),
        _buildActionCard(
          'My Exhibitions',
          'View and manage your exhibitions',
          Icons.event,
          () => context.go('/organizer/my-exhibitions'),
        ),
        const SizedBox(height: 16),
        _buildActionCard(
          'Stall Bookings',
          'Manage stall bookings and requests',
          Icons.store,
          () => context.go('/organizer/stall-bookings'),
        ),
        const SizedBox(height: 16),
        _buildActionCard(
          'Analytics',
          'View exhibition performance metrics',
          Icons.analytics,
          () => context.go('/organizer/analytics'),
        ),
      ],
    );
  }

  Widget _buildBrandDashboard() {
    return Column(
      children: [
        _buildActionCard(
          'Browse Exhibitions',
          'Find and book exhibition stalls',
          Icons.search,
          () => context.go('/brand/browse-exhibitions'),
        ),
        const SizedBox(height: 16),
        _buildActionCard(
          'My Bookings',
          'View your stall bookings',
          Icons.bookmark,
          () => context.go('/brand/my-bookings'),
        ),
        const SizedBox(height: 16),
        _buildActionCard(
          'My Products',
          'Manage your product catalog',
          Icons.inventory,
          () => context.go('/brand/my-products'),
        ),
      ],
    );
  }

  Widget _buildShopperDashboard() {
    return Column(
      children: [
        _buildActionCard(
          'Upcoming Exhibitions',
          'Discover upcoming exhibitions near you',
          Icons.event_available,
          () => context.go('/shopper/upcoming-exhibitions'),
        ),
        const SizedBox(height: 16),
        _buildActionCard(
          'Exclusive Deals',
          'View exclusive deals from brands',
          Icons.local_offer,
          () => context.go('/shopper/exclusive-deals'),
        ),
        const SizedBox(height: 16),
        _buildActionCard(
          'Saved Items',
          'View your saved products and exhibitions',
          Icons.favorite,
          () => context.go('/shopper/saved-items'),
        ),
      ],
    );
  }

  Widget _buildActionCard(
    String title,
    String subtitle,
    IconData icon,
    VoidCallback onTap,
  ) {
    return Card(
      child: ListTile(
        leading: Icon(icon, color: Theme.of(context).colorScheme.primary),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
} 