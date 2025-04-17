import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../models/booking_model.dart';
import '../../services/booking_service.dart';

class OrganizerBookingsScreen extends StatefulWidget {
  final String? exhibitionId;

  const OrganizerBookingsScreen({Key? key, this.exhibitionId}) : super(key: key);

  @override
  State<OrganizerBookingsScreen> createState() => _OrganizerBookingsScreenState();
}

class _OrganizerBookingsScreenState extends State<OrganizerBookingsScreen> {
  final _bookingService = BookingService();
  List<BookingModel> _bookings = [];
  bool _isLoading = true;
  String _selectedFilter = 'all';

  @override
  void initState() {
    super.initState();
    _loadBookings();
  }

  Future<void> _loadBookings() async {
    try {
      final bookings = widget.exhibitionId != null
          ? await _bookingService.getBookingsByExhibition(widget.exhibitionId!)
          : await _bookingService.getBookings();
      setState(() {
        _bookings = bookings;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading bookings: $e')),
        );
      }
    }
  }

  List<BookingModel> _filterBookings() {
    if (_selectedFilter == 'all') {
      return _bookings;
    }
    return _bookings.where((booking) => booking.status == _selectedFilter).toList();
  }

  Future<void> _updateBookingStatus(BookingModel booking, String status) async {
    try {
      if (status == 'confirmed') {
        await _bookingService.confirmBooking(booking.id);
      } else if (status == 'cancelled') {
        await _bookingService.cancelBooking(booking.id);
      }
      await _loadBookings();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Booking ${status} successfully')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error updating booking: $e')),
        );
      }
    }
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.exhibitionId != null ? 'Exhibition Bookings' : 'All Bookings'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      _buildFilterChip('All', 'all'),
                      _buildFilterChip('Pending', 'pending'),
                      _buildFilterChip('Confirmed', 'confirmed'),
                      _buildFilterChip('Cancelled', 'cancelled'),
                    ],
                  ),
                ),
                Expanded(
                  child: _bookings.isEmpty
                      ? const Center(child: Text('No bookings found'))
                      : ListView.builder(
                          itemCount: _filterBookings().length,
                          itemBuilder: (context, index) {
                            final booking = _filterBookings()[index];
                            return _buildBookingCard(booking);
                          },
                        ),
                ),
              ],
            ),
    );
  }

  Widget _buildFilterChip(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: FilterChip(
        label: Text(label),
        selected: _selectedFilter == value,
        onSelected: (selected) {
          setState(() => _selectedFilter = value);
        },
      ),
    );
  }

  Widget _buildBookingCard(BookingModel booking) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () => context.push('/organizer/bookings/${booking.id}'),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Booking #${booking.id.length > 8 ? booking.id.substring(0, 8) : booking.id}',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                    decoration: BoxDecoration(
                      color: _getStatusColor(booking.status).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Text(
                      booking.status.capitalize(),
                      style: TextStyle(
                        color: _getStatusColor(booking.status),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'Stall Size: ${booking.stallSize}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 4),
              Text(
                'Amount: ₹${booking.amount.toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 4),
              Text(
                'Booked on: ${_formatDate(booking.bookingDate)}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              if (booking.confirmedDate != null) ...[
                const SizedBox(height: 4),
                Text(
                  'Confirmed on: ${_formatDate(booking.confirmedDate!)}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
              if (booking.cancelledDate != null) ...[
                const SizedBox(height: 4),
                Text(
                  'Cancelled on: ${_formatDate(booking.cancelledDate!)}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
              if (booking.status == 'pending') ...[
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => _updateBookingStatus(booking, 'confirmed'),
                      child: const Text('Confirm'),
                    ),
                    TextButton(
                      onPressed: () => _updateBookingStatus(booking, 'cancelled'),
                      child: const Text('Cancel'),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
} 