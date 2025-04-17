import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../utils/placeholder_image.dart';

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
          'status': 'Open for Booking',
          'availableStalls': 15,
          'stallPrice': '\$999',
          'totalStalls': 50,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exhibition Details'),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark_border),
            onPressed: () {
              // TODO: Implement bookmark functionality
            },
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _exhibitionData == null
              ? const Center(child: Text('No data found'))
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(
                        _exhibitionData!['image'],
                        width: double.infinity,
                        height: 250,
                        fit: BoxFit.cover,
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
                            const SizedBox(height: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: primaryColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                _exhibitionData!['status'],
                                style: TextStyle(
                                  color: primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
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
                            ),
                            const SizedBox(height: 8),
                            _buildInfoRow(
                              Icons.map,
                              _exhibitionData!['address'],
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
                              'Stall Information',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            _buildStallInfo(),
                            const SizedBox(height: 24),
                            ElevatedButton(
                              onPressed: () => context.go('/brand/exhibitions/${widget.exhibitionId}/book'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primaryColor,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text('Book a Stall'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
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
    );
  }

  Widget _buildStallInfo() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Available Stalls',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  '${_exhibitionData!['availableStalls']}/${_exhibitionData!['totalStalls']}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Stall Price',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  _exhibitionData!['stallPrice'],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
} 