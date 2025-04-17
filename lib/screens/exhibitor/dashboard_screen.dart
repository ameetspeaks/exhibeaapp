import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool _isLoading = true;
  Map<String, dynamic> _stats = {};
  List<Map<String, dynamic>> _recentExhibitions = [];

  @override
  void initState() {
    super.initState();
    _loadDashboardData();
  }

  Future<void> _loadDashboardData() async {
    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));
    
    setState(() {
      _stats = {
        'totalExhibitions': 5,
        'activeExhibitions': 2,
        'totalBookings': 12,
        'pendingBookings': 3,
      };
      
      _recentExhibitions = [
        {
          'id': '1',
          'name': 'Tech Expo 2024',
          'date': '2024-03-15',
          'location': 'New York',
          'status': 'active',
        },
        {
          'id': '2',
          'name': 'Fashion Week',
          'date': '2024-04-20',
          'location': 'Los Angeles',
          'status': 'upcoming',
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
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push('/exhibitor/exhibitions/new'),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildStatsGrid(),
          const SizedBox(height: 24),
          _buildRecentExhibitions(),
        ],
      ),
    );
  }

  Widget _buildStatsGrid() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      children: [
        _buildStatCard(
          'Total Exhibitions',
          _stats['totalExhibitions'].toString(),
          Icons.event,
          Colors.blue,
        ),
        _buildStatCard(
          'Active Exhibitions',
          _stats['activeExhibitions'].toString(),
          Icons.event_available,
          Colors.green,
        ),
        _buildStatCard(
          'Total Bookings',
          _stats['totalBookings'].toString(),
          Icons.book,
          Colors.orange,
        ),
        _buildStatCard(
          'Pending Bookings',
          _stats['pendingBookings'].toString(),
          Icons.pending_actions,
          Colors.red,
        ),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 32, color: color),
            const SizedBox(height: 8),
            Text(
              value,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentExhibitions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recent Exhibitions',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _recentExhibitions.length,
          itemBuilder: (context, index) {
            final exhibition = _recentExhibitions[index];
            return Card(
              child: ListTile(
                title: Text(exhibition['name']),
                subtitle: Text('${exhibition['date']} • ${exhibition['location']}'),
                trailing: Chip(
                  label: Text(exhibition['status']),
                  backgroundColor: exhibition['status'] == 'active'
                      ? Colors.green.withOpacity(0.2)
                      : Colors.orange.withOpacity(0.2),
                  labelStyle: TextStyle(
                    color: exhibition['status'] == 'active'
                        ? Colors.green
                        : Colors.orange,
                  ),
                ),
                onTap: () => context.push('/exhibitor/exhibitions/${exhibition['id']}'),
              ),
            );
          },
        ),
      ],
    );
  }
} 