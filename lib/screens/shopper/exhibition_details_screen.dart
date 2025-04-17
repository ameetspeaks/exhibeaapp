import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

class ExhibitionDetailsScreen extends StatefulWidget {
  final String exhibitionId;

  const ExhibitionDetailsScreen({
    super.key,
    required this.exhibitionId,
  });

  @override
  State<ExhibitionDetailsScreen> createState() => _ExhibitionDetailsScreenState();
}

class _ExhibitionDetailsScreenState extends State<ExhibitionDetailsScreen> {
  bool _isLoading = false;
  bool _hasShownInterest = false;
  Map<String, dynamic>? _exhibitionData;
  final Color primaryColor = const Color(0xFF389DF3);
  final Color accentColor = const Color(0xFFE97917);

  @override
  void initState() {
    super.initState();
    _loadExhibitionData();
  }

  Future<void> _loadExhibitionData() async {
    setState(() => _isLoading = true);

    try {
      // TODO: Implement exhibition data loading logic
      await Future.delayed(const Duration(seconds: 1)); // Simulated API call
      setState(() {
        _exhibitionData = {
          'id': widget.exhibitionId,
          'name': 'Spring Fashion Show',
          'date': '2024-04-01',
          'time': '10:00 AM - 6:00 PM',
          'location': 'Convention Center',
          'address': '123 Main Street, City, State 12345',
          'description': 'Join us for the most anticipated fashion event of the season! Experience the latest trends from top designers and discover emerging talent.',
          'image': 'https://images.unsplash.com/photo-1445205170230-053b83016050?w=500&auto=format&fit=crop&q=60',
          'participatingBrands': [
            {
              'id': '1',
              'name': 'Fashion Forward',
              'category': 'Apparel',
              'image': 'https://images.unsplash.com/photo-1445205170230-053b83016050?w=500&auto=format&fit=crop&q=60',
            },
            {
              'id': '2',
              'name': 'Tech Innovators',
              'category': 'Electronics',
              'image': 'https://images.unsplash.com/photo-1523381210434-271e8be1f52b?w=500&auto=format&fit=crop&q=60',
            },
          ],
          'highlights': [
            'Live fashion shows',
            'Exclusive product launches',
            'Meet & greet with designers',
            'Special discounts',
            'Networking opportunities',
          ],
        };
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading exhibition data: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _openMaps() async {
    final Uri url = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=${_exhibitionData!['address']}',
    );
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not open maps')),
        );
      }
    }
  }

  Future<void> _showInterest() async {
    setState(() => _isLoading = true);
    try {
      // TODO: Implement API call to show interest
      await Future.delayed(const Duration(seconds: 1)); // Simulated API call
      setState(() => _hasShownInterest = true);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Interest shown successfully!')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error showing interest: $e')),
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
        title: const Text('Exhibition Details'),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _exhibitionData == null
              ? const Center(child: Text('No data found'))
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Image.network(
                            _exhibitionData!['image'],
                            width: double.infinity,
                            height: 250,
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                            bottom: 16,
                            right: 16,
                            child: ElevatedButton.icon(
                              onPressed: _hasShownInterest ? null : _showInterest,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: _hasShownInterest ? Colors.grey : primaryColor,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 12,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              icon: Icon(_hasShownInterest ? Icons.check : Icons.favorite),
                              label: Text(_hasShownInterest ? 'Interested' : 'Show Interest'),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _exhibitionData!['name'],
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 16),
                            _buildInfoRow(
                              Icons.calendar_today,
                              '${_exhibitionData!['date']} • ${_exhibitionData!['time']}',
                            ),
                            const SizedBox(height: 8),
                            _buildInfoRow(
                              Icons.location_on,
                              _exhibitionData!['location'],
                              onTap: _openMaps,
                            ),
                            const SizedBox(height: 8),
                            _buildInfoRow(
                              Icons.map,
                              _exhibitionData!['address'],
                              onTap: _openMaps,
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'About',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              _exhibitionData!['description'],
                              style: const TextStyle(fontSize: 16),
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'Highlights',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            ..._exhibitionData!['highlights'].map<Widget>((highlight) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.check_circle,
                                      color: primaryColor,
                                      size: 20,
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        highlight,
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                            const SizedBox(height: 16),
                            const Text(
                              'Participating Brands',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            SizedBox(
                              height: 120,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: _exhibitionData!['participatingBrands'].length,
                                itemBuilder: (context, index) {
                                  final brand = _exhibitionData!['participatingBrands'][index];
                                  return Container(
                                    width: 100,
                                    margin: const EdgeInsets.only(right: 16.0),
                                    child: InkWell(
                                      onTap: () => context.go('/shopper/brands/${brand['id']}'),
                                      borderRadius: BorderRadius.circular(12),
                                      child: Column(
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(12),
                                            child: Image.network(
                                              brand['image'],
                                              width: 100,
                                              height: 100,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            brand['name'],
                                            style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
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

  Widget _buildInfoRow(IconData icon, String text, {VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, color: primaryColor, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
} 