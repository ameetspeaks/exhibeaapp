import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BrandBookingDetailsScreen extends StatefulWidget {
  final String bookingId;

  const BrandBookingDetailsScreen({
    super.key,
    required this.bookingId,
  });

  @override
  State<BrandBookingDetailsScreen> createState() => _BrandBookingDetailsScreenState();
}

class _BrandBookingDetailsScreenState extends State<BrandBookingDetailsScreen> {
  bool _isLoading = false;
  Map<String, dynamic>? _booking;

  @override
  void initState() {
    super.initState();
    _loadBookingDetails();
  }

  Future<void> _loadBookingDetails() async {
    setState(() => _isLoading = true);

    try {
      // TODO: Implement booking details loading logic
      await Future.delayed(const Duration(seconds: 1)); // Simulated API call
      setState(() {
        _booking = {
          'id': widget.bookingId,
          'exhibition': 'Tech Expo 2024',
          'stallNumber': 'A-101',
          'date': 'March 15-17, 2024',
          'status': 'Confirmed',
          'paymentStatus': 'Paid',
          'price': '₹50,000',
          'description': 'Premium stall at the main entrance',
          'contactPerson': 'John Doe',
          'contactEmail': 'john@example.com',
          'contactPhone': '+91 9876543210',
        };
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading booking details: $e')),
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
        title: const Text('Booking Details'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _booking == null
              ? const Center(child: Text('No booking details found'))
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildInfoCard(
                        title: 'Exhibition',
                        content: Text(_booking!['exhibition']),
                      ),
                      const SizedBox(height: 16),
                      _buildInfoCard(
                        title: 'Stall Details',
                        content: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Stall Number: ${_booking!['stallNumber']}'),
                            Text('Price: ${_booking!['price']}'),
                            Text('Description: ${_booking!['description']}'),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildInfoCard(
                        title: 'Date',
                        content: Text(_booking!['date']),
                      ),
                      const SizedBox(height: 16),
                      _buildInfoCard(
                        title: 'Status',
                        content: Row(
                          children: [
                            _buildStatusChip(
                              label: _booking!['status'],
                              color: _booking!['status'] == 'Confirmed'
                                  ? Colors.green
                                  : Colors.orange,
                            ),
                            const SizedBox(width: 8),
                            _buildStatusChip(
                              label: _booking!['paymentStatus'],
                              color: _booking!['paymentStatus'] == 'Paid'
                                  ? Colors.green
                                  : Colors.orange,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildInfoCard(
                        title: 'Contact Information',
                        content: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Contact Person: ${_booking!['contactPerson']}'),
                            Text('Email: ${_booking!['contactEmail']}'),
                            Text('Phone: ${_booking!['contactPhone']}'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }

  Widget _buildInfoCard({required String title, required Widget content}) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            content,
          ],
        ),
      ),
    );
  }

  Widget _buildStatusChip({required String label, required Color color}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        style: TextStyle(color: color),
      ),
    );
  }
} 