import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ShopperDashboardScreen extends StatefulWidget {
  const ShopperDashboardScreen({super.key});

  @override
  State<ShopperDashboardScreen> createState() => _ShopperDashboardScreenState();
}

class _ShopperDashboardScreenState extends State<ShopperDashboardScreen> {
  int _selectedIndex = 0;
  final List<Widget> _screens = [
    const _HomeScreen(),
    const _DiscoverScreen(),
    const _BookmarksScreen(),
    const _ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopper Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // TODO: Navigate to notifications
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              context.go('/login');
            },
          ),
        ],
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.explore),
            label: 'Discover',
          ),
          NavigationDestination(
            icon: Icon(Icons.bookmark),
            label: 'Bookmarks',
          ),
          NavigationDestination(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class _HomeScreen extends StatelessWidget {
  const _HomeScreen();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildWelcomeCard(context),
          const SizedBox(height: 24),
          _buildQuickActions(context),
          const SizedBox(height: 24),
          _buildUpcomingExhibitions(context),
        ],
      ),
    );
  }

  Widget _buildWelcomeCard(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome back!',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              'Discover amazing exhibitions and events near you.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Actions',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          children: [
            _buildActionCard(
              context,
              icon: Icons.search,
              title: 'Search Exhibitions',
              onTap: () => context.go('/shopper/search'),
            ),
            _buildActionCard(
              context,
              icon: Icons.calendar_today,
              title: 'My Schedule',
              onTap: () => context.go('/shopper/schedule'),
            ),
            _buildActionCard(
              context,
              icon: Icons.confirmation_number,
              title: 'My Tickets',
              onTap: () => context.go('/shopper/tickets'),
            ),
            _buildActionCard(
              context,
              icon: Icons.map,
              title: 'Nearby Events',
              onTap: () => context.go('/shopper/nearby'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 32),
              const SizedBox(height: 8),
              Text(
                title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUpcomingExhibitions(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recommended for You',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 3, // Replace with actual data
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                title: Text('Exhibition ${index + 1}'),
                subtitle: Text('Date: ${DateTime.now().add(Duration(days: index + 1))}'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () => context.go('/shopper/exhibitions/$index'),
              ),
            );
          },
        ),
      ],
    );
  }
}

class _DiscoverScreen extends StatelessWidget {
  const _DiscoverScreen();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Discover Screen'),
    );
  }
}

class _BookmarksScreen extends StatelessWidget {
  const _BookmarksScreen();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Bookmarks Screen'),
    );
  }
}

class _ProfileScreen extends StatelessWidget {
  const _ProfileScreen();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Profile Screen'),
    );
  }
} 