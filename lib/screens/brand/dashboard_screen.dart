import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../services/brand_service.dart';

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
  final BrandService _brandService = BrandService();

  @override
  void initState() {
    super.initState();
    _loadDashboardData();
  }

  Future<void> _loadDashboardData() async {
    setState(() => _isLoading = true);

    try {
      final activeBookings = await _brandService.getActiveBookings();
      final upcomingExhibitions = await _brandService.getUpcomingExhibitions();
      final lookbook = await _brandService.getLookBook();

      setState(() {
        _dashboardData = {
          'activeBookings': activeBookings,
          'upcomingExhibitions': upcomingExhibitions,
          'lookbook': lookbook,
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
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildDashboardItem(
            context,
            'Profile',
            Icons.person,
            () => context.go('/brand/profile'),
          ),
          _buildDashboardItem(
            context,
            'Lookbook',
            Icons.photo_library,
            () => context.go('/brand/lookbook'),
          ),
          _buildDashboardItem(
            context,
            'Exhibitions',
            Icons.event,
            () => context.go('/brand/exhibitions'),
          ),
          _buildDashboardItem(
            context,
            'Bookings',
            Icons.book,
            () => context.go('/brand/bookings'),
          ),
          _buildDashboardItem(
            context,
            'Products',
            Icons.shopping_bag,
            () => context.go('/brand/products'),
          ),
        ],
      ),
    );
  }

  Widget _buildDashboardItem(
    BuildContext context,
    String title,
    IconData icon,
    VoidCallback onTap,
  ) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48),
            const SizedBox(height: 8),
            Text(title),
          ],
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