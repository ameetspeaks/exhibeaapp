import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

class BrandDashboardScreen extends StatefulWidget {
  const BrandDashboardScreen({super.key});

  @override
  State<BrandDashboardScreen> createState() => _BrandDashboardScreenState();
}

class _BrandDashboardScreenState extends State<BrandDashboardScreen> {
  bool _isLoading = false;
  Map<String, dynamic>? _dashboardData;
  final Color brandColor = const Color(0xFF389DF3);
  final Color buttonColor = const Color(0xFFE97917);
  final Color textColor = const Color(0xFFFFFFFF);

  @override
  void initState() {
    super.initState();
    _loadDashboardData();
  }

  Future<void> _loadDashboardData() async {
    setState(() => _isLoading = true);

    try {
      // TODO: Implement dashboard data loading logic
      await Future.delayed(const Duration(seconds: 1)); // Simulated API call
      setState(() {
        _dashboardData = {
          'activeBookings': [
            {
              'id': '1',
              'exhibition': 'Tech Expo 2024',
              'stall': 'A-101',
              'date': '2024-03-15',
              'status': 'Confirmed',
            },
            {
              'id': '2',
              'exhibition': 'Fashion Week',
              'stall': 'B-203',
              'date': '2024-03-20',
              'status': 'Confirmed',
            },
          ],
          'upcomingExhibitions': [
            {
              'id': '1',
              'name': 'Spring Fashion Show',
              'date': '2024-04-01',
              'location': 'Convention Center',
              'availableStalls': 12,
            },
            {
              'id': '2',
              'name': 'Tech Innovation Summit',
              'date': '2024-04-15',
              'location': 'Tech Hub',
              'availableStalls': 8,
            },
          ],
          'lookbook': [
            {
              'id': '1',
              'title': 'Spring Collection 2024',
              'type': 'image',
              'url': 'https://images.unsplash.com/photo-1445205170230-053b83016050?w=500&auto=format&fit=crop&q=60',
              'description': 'Our latest spring collection featuring innovative designs',
            },
            {
              'id': '2',
              'title': 'Tech Fusion Catalog',
              'type': 'pdf',
              'url': 'https://example.com/catalog.pdf',
              'description': 'Download our complete product catalog',
            },
            {
              'id': '3',
              'title': 'Summer Collection',
              'type': 'image',
              'url': 'https://images.unsplash.com/photo-1523381210434-271e8be1f52b?w=500&auto=format&fit=crop&q=60',
              'description': 'Preview our upcoming summer collection',
            },
          ],
        };
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading dashboard data: $e')),
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
        title: const Text('Dashboard'),
        backgroundColor: brandColor,
        foregroundColor: textColor,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _dashboardData == null
              ? const Center(child: Text('No data found'))
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSectionTitle('Active Bookings'),
                        _buildActiveBookings(),
                        const SizedBox(height: 24),
                        _buildSectionTitle('Upcoming Exhibitions'),
                        _buildUpcomingExhibitions(),
                        const SizedBox(height: 24),
                        _buildSectionTitle(
                          'LookBook',
                          onViewAll: () => context.push('/brand/lookbook'),
                        ),
                        _buildLookBookPreview(),
                      ],
                    ),
                  ),
                ),
    );
  }

  Widget _buildSectionTitle(String title, {VoidCallback? onViewAll}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: brandColor,
            ),
          ),
          if (onViewAll != null)
            TextButton(
              onPressed: onViewAll,
              style: TextButton.styleFrom(
                foregroundColor: buttonColor,
              ),
              child: const Text('View All'),
            ),
        ],
      ),
    );
  }

  Widget _buildActiveBookings() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _dashboardData!['activeBookings'].length,
      itemBuilder: (context, index) {
        final booking = _dashboardData!['activeBookings'][index];
        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            onTap: () => context.go('/brand/bookings/${booking['id']}'),
            contentPadding: const EdgeInsets.all(12),
            title: Text(
              booking['exhibition'],
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.place, size: 16, color: brandColor),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        booking['stall'],
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.calendar_today, size: 16, color: brandColor),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        booking['date'],
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.green[100],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                booking['status'],
                style: TextStyle(
                  color: Colors.green[800],
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildUpcomingExhibitions() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _dashboardData!['upcomingExhibitions'].length,
      itemBuilder: (context, index) {
        final exhibition = _dashboardData!['upcomingExhibitions'][index];
        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            onTap: () => context.go('/brand/exhibitions/${exhibition['id']}'),
            contentPadding: const EdgeInsets.all(12),
            title: Text(
              exhibition['name'],
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.calendar_today, size: 16, color: brandColor),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        exhibition['date'],
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.location_on, size: 16, color: brandColor),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        exhibition['location'],
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.store, size: 16, color: brandColor),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        '${exhibition['availableStalls']} stalls available',
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            trailing: ElevatedButton(
              onPressed: () => context.go('/brand/exhibitions/${exhibition['id']}/book'),
              style: ElevatedButton.styleFrom(
                backgroundColor: buttonColor,
                foregroundColor: textColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
              child: const Text('Book Now'),
            ),
          ),
        );
      },
    );
  }

  Future<void> _openLookBookItem(Map<String, dynamic> look) async {
    if (look['type'] == 'pdf') {
      final Uri url = Uri.parse(look['url']);
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Could not open PDF')),
          );
        }
      }
    } else {
      if (mounted) {
        showDialog(
          context: context,
          builder: (context) => Dialog(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.network(
                  look['url'],
                  fit: BoxFit.contain,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        look['title'],
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(look['description']),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Close'),
                ),
              ],
            ),
          ),
        );
      }
    }
  }

  Widget _buildLookBookPreview() {
    return SizedBox(
      height: 145,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _dashboardData!['lookbook'].length,
        itemBuilder: (context, index) {
          final look = _dashboardData!['lookbook'][index];
          return Container(
            width: 130,
            margin: const EdgeInsets.only(right: 8.0),
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: InkWell(
                onTap: () => _openLookBookItem(look),
                borderRadius: BorderRadius.circular(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                      child: look['type'] == 'image'
                          ? Image.network(
                              look['url'],
                              width: 130,
                              height: 125,
                              fit: BoxFit.cover,
                              loadingBuilder: (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Container(
                                  width: 130,
                                  height: 125,
                                  color: Colors.grey[200],
                                  child: const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              },
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  width: 130,
                                  height: 125,
                                  color: Colors.grey[200],
                                  child: const Icon(
                                    Icons.error_outline,
                                    color: Colors.red,
                                  ),
                                );
                              },
                            )
                          : Container(
                              width: 130,
                              height: 125,
                              color: Colors.grey[200],
                              child: const Icon(
                                Icons.picture_as_pdf,
                                size: 36,
                                color: Colors.red,
                              ),
                            ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 0.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            look['title'],
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            look['description'],
                            style: const TextStyle(fontSize: 8),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
} 