import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class StallDetailsScreen extends StatefulWidget {
  final String exhibitionId;

  const StallDetailsScreen({
    Key? key,
    required this.exhibitionId,
  }) : super(key: key);

  @override
  State<StallDetailsScreen> createState() => _StallDetailsScreenState();
}

class _StallDetailsScreenState extends State<StallDetailsScreen> {
  bool _isLoading = true;
  Map<String, dynamic>? _stall;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _loadStallDetails();
  }

  Future<void> _loadStallDetails() async {
    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));
    
    setState(() {
      _stall = {
        'id': '1',
        'number': 'A1',
        'size': '3x3m',
        'price': '₹25,000',
        'status': 'available',
        'type': 'standard',
        'description': 'Standard stall with basic amenities',
        'amenities': ['Power outlet', 'WiFi', 'Table', 'Chairs'],
        'bookings': [
          {
            'id': '1',
            'brand': 'TechCorp',
            'contact': 'john@techcorp.com',
            'startDate': '2024-03-01',
            'endDate': '2024-03-03',
            'status': 'confirmed',
          },
        ],
      };
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading || _stall == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  'Stall ${_stall!['number']}',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),
              Chip(
                label: Text(_stall!['status']),
                backgroundColor: _getStatusColor(_stall!['status']).withOpacity(0.2),
                labelStyle: TextStyle(
                  color: _getStatusColor(_stall!['status']),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Basic Info
          _buildSection(
            title: 'Basic Information',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInfoRow('Size', _stall!['size']),
                _buildInfoRow('Price', _stall!['price']),
                _buildInfoRow('Type', _stall!['type']),
                _buildInfoRow('Description', _stall!['description']),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Amenities
          _buildSection(
            title: 'Amenities',
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _stall!['amenities'].map<Widget>((amenity) {
                return Chip(
                  label: Text(amenity),
                  backgroundColor: Colors.blue[50],
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 24),

          // Bookings
          if (_stall!['bookings'] != null && _stall!['bookings'].isNotEmpty)
            _buildSection(
              title: 'Bookings',
              child: Column(
                children: _stall!['bookings'].map<Widget>((booking) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            booking['brand'],
                            style: Theme.of(context).textTheme.titleMedium,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 8),
                          _buildInfoRow('Contact', booking['contact']),
                          _buildInfoRow('Start Date', booking['startDate']),
                          _buildInfoRow('End Date', booking['endDate']),
                          const SizedBox(height: 8),
                          Chip(
                            label: Text(booking['status']),
                            backgroundColor: _getBookingStatusColor(booking['status']).withOpacity(0.2),
                            labelStyle: TextStyle(
                              color: _getBookingStatusColor(booking['status']),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),

          // Action Buttons
          const SizedBox(height: 24),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _isEditing = !_isEditing;
                  });
                },
                child: Text(_isEditing ? 'Save Changes' : 'Edit Stall'),
              ),
              ElevatedButton(
                onPressed: () {
                  // TODO: Show booking dialog
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                child: const Text('New Booking'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required Widget child,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        child,
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: TextStyle(
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'available':
        return Colors.green;
      case 'booked':
        return Colors.blue;
      case 'reserved':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  Color _getBookingStatusColor(String status) {
    switch (status) {
      case 'confirmed':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
} 