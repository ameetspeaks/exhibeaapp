import 'package:flutter/material.dart';
import '../../models/booking_model.dart';
import '../../services/booking_service.dart';

class StallBookingsScreen extends StatefulWidget {
  final String exhibitionId;

  const StallBookingsScreen({
    super.key,
    required this.exhibitionId,
  });

  @override
  State<StallBookingsScreen> createState() => _StallBookingsScreenState();
}

class _StallBookingsScreenState extends State<StallBookingsScreen> {
  final BookingService _bookingService = BookingService();
  bool _isLoading = true;
  List<BookingModel> _bookings = [];

  @override
  void initState() {
    super.initState();
    _loadBookings();
  }

  Future<void> _loadBookings() async {
    try {
      setState(() => _isLoading = true);
      final bookings = await _bookingService.getBookingsByExhibitionId(widget.exhibitionId);
      setState(() {
        _bookings = bookings;
        _isLoading = false;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading bookings: $e')),
        );
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stall Bookings'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _bookings.isEmpty
              ? const Center(child: Text('No bookings found'))
              : ListView.builder(
                  itemCount: _bookings.length,
                  itemBuilder: (context, index) {
                    final booking = _bookings[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: ListTile(
                        title: Text('Booking #${booking.id}'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Brand: ${booking.brandName}'),
                            Text('Status: ${booking.status}'),
                            Text('Payment Status: ${booking.paymentStatus}'),
                          ],
                        ),
                        trailing: Text(
                          '₹${booking.totalAmount}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        onTap: () {
                          // Navigate to booking details
                          // context.push('/exhibitor/bookings/${booking.id}');
                        },
                      ),
                    );
                  },
                ),
    );
  }
} 