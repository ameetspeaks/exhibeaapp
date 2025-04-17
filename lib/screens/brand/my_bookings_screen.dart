import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BrandBookingsScreen extends StatefulWidget {
  const BrandBookingsScreen({super.key});

  @override
  State<BrandBookingsScreen> createState() => _BrandBookingsScreenState();
}

class _BrandBookingsScreenState extends State<BrandBookingsScreen> {
  bool _isLoading = false;
  List<Map<String, dynamic>> _bookings = [];

  @override
  void initState() {
    super.initState();
    _loadBookings();
  }

  Future<void> _loadBookings() async {
    setState(() => _isLoading = true);

    try {
      // TODO: Implement booking loading logic
      await Future.delayed(const Duration(seconds: 1)); // Simulated API call
      setState(() {
        _bookings = [
          {
            'id': '1',
            'exhibition': 'Tech Expo 2024',
            'stallNumber': 'A-101',
            'date': 'March 15-17, 2024',
            'status': 'Confirmed',
            'paymentStatus': 'Paid',
          },
          {
            'id': '2',
            'exhibition': 'Fashion Week',
            'stallNumber': 'B-205',
            'date': 'April 1-7, 2024',
            'status': 'Pending',
            'paymentStatus': 'Pending',
          },
        ];
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading bookings: $e')),
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
        title: const Text('My Bookings'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: _bookings.length,
              itemBuilder: (context, index) {
                final booking = _bookings[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: ListTile(
                    title: Text(
                      booking['exhibition'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Stall: ${booking['stallNumber']}'),
                        Text('Date: ${booking['date']}'),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: booking['status'] == 'Confirmed'
                                    ? Colors.green.withOpacity(0.2)
                                    : Colors.orange.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                booking['status'],
                                style: TextStyle(
                                  color: booking['status'] == 'Confirmed'
                                      ? Colors.green
                                      : Colors.orange,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: booking['paymentStatus'] == 'Paid'
                                    ? Colors.green.withOpacity(0.2)
                                    : Colors.orange.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                booking['paymentStatus'],
                                style: TextStyle(
                                  color: booking['paymentStatus'] == 'Paid'
                                      ? Colors.green
                                      : Colors.orange,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.visibility),
                      onPressed: () => context.go('/brand/bookings/${booking['id']}'),
                    ),
                  ),
                );
              },
            ),
    );
  }
} 