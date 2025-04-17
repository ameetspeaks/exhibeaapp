import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ExhibitionDetailsScreen extends StatefulWidget {
  final String exhibitionId;

  const ExhibitionDetailsScreen({super.key, required this.exhibitionId});

  @override
  State<ExhibitionDetailsScreen> createState() => _ExhibitionDetailsScreenState();
}

class _ExhibitionDetailsScreenState extends State<ExhibitionDetailsScreen> {
  bool _isLoading = true;
  Map<String, dynamic>? _exhibition;
  List<Map<String, dynamic>> _bookings = [];

  @override
  void initState() {
    super.initState();
    _loadExhibitionDetails();
  }

  Future<void> _loadExhibitionDetails() async {
    setState(() => _isLoading = true);
    
    // Simulate API calls
    await Future.delayed(const Duration(seconds: 1));
    
    setState(() {
      _exhibition = {
        'id': widget.exhibitionId,
        'name': 'Tech Expo 2024',
        'description': 'A showcase of the latest technology innovations',
        'date': '2024-03-15',
        'endDate': '2024-03-17',
        'location': 'New York',
        'status': 'active',
        'imageUrl': 'https://example.com/tech-expo.jpg',
        'capacity': 100,
        'bookedStalls': 75,
        'pricePerStall': 1000,
      };
      
      _bookings = [
        {
          'id': '1',
          'brandName': 'TechCorp',
          'stalls': 2,
          'status': 'confirmed',
          'bookingDate': '2024-02-01',
        },
        {
          'id': '2',
          'brandName': 'InnovateX',
          'stalls': 1,
          'status': 'pending',
          'bookingDate': '2024-02-05',
        },
      ];
      
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading || _exhibition == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(_exhibition!['name']),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => context.push('/exhibitor/exhibitions/${widget.exhibitionId}/edit'),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Image.network(
              _exhibition!['imageUrl'],
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[200],
                  child: const Icon(Icons.image, size: 50),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _exhibition!['name'],
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _exhibition!['description'],
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 16),
                  _buildInfoRow(Icons.calendar_today, 'Date', '${_exhibition!['date']} - ${_exhibition!['endDate']}'),
                  _buildInfoRow(Icons.location_on, 'Location', _exhibition!['location']),
                  _buildInfoRow(Icons.event_seat, 'Capacity', '${_exhibition!['bookedStalls']}/${_exhibition!['capacity']} stalls booked'),
                  _buildInfoRow(Icons.attach_money, 'Price per Stall', '\$${_exhibition!['pricePerStall']}'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Bookings',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          _bookings.isEmpty
              ? const Center(
                  child: Text('No bookings yet'),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _bookings.length,
                  itemBuilder: (context, index) {
                    final booking = _bookings[index];
                    return Card(
                      child: ListTile(
                        title: Text(booking['brandName']),
                        subtitle: Text('${booking['stalls']} stalls • Booked on ${booking['bookingDate']}'),
                        trailing: Chip(
                          label: Text(booking['status']),
                          backgroundColor: _getStatusColor(booking['status']).withOpacity(0.2),
                          labelStyle: TextStyle(
                            color: _getStatusColor(booking['status']),
                          ),
                        ),
                        onTap: () => context.push('/exhibitor/exhibitions/${widget.exhibitionId}/bookings/${booking['id']}'),
                      ),
                    );
                  },
                ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.grey[600]),
          const SizedBox(width: 8),
          Text(
            '$label: ',
            style: TextStyle(color: Colors.grey[600]),
          ),
          Text(value),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
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