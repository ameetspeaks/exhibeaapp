import 'package:flutter/material.dart';

class BookingDetailsCard extends StatelessWidget {
  final Map<String, String> booking;

  const BookingDetailsCard({
    Key? key,
    required this.booking,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Booking #${booking['id']}',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                _buildStatusChip(context),
              ],
            ),
            const SizedBox(height: 16),
            _buildSection(
              context,
              'Customer Information',
              [
                _buildInfoRow(context, Icons.person, 'Name', booking['customer'] ?? 'Unknown'),
                _buildInfoRow(context, Icons.email, 'Email', booking['email'] ?? 'N/A'),
                _buildInfoRow(context, Icons.phone, 'Phone', booking['phone'] ?? 'N/A'),
              ],
            ),
            const SizedBox(height: 16),
            _buildSection(
              context,
              'Booking Details',
              [
                _buildInfoRow(context, Icons.event, 'Exhibition', booking['exhibition'] ?? 'N/A'),
                _buildInfoRow(context, Icons.location_on, 'Venue', booking['venue'] ?? 'N/A'),
                _buildInfoRow(context, Icons.calendar_today, 'Date', booking['date'] ?? 'N/A'),
                _buildInfoRow(context, Icons.access_time, 'Time', booking['time'] ?? 'N/A'),
                _buildInfoRow(context, Icons.grid_view, 'Stall', booking['stall'] ?? 'N/A'),
              ],
            ),
            const SizedBox(height: 16),
            _buildSection(
              context,
              'Payment Information',
              [
                _buildInfoRow(context, Icons.attach_money, 'Amount', booking['amount'] ?? '₹0'),
                _buildInfoRow(context, Icons.payment, 'Payment Method', booking['paymentMethod'] ?? 'N/A'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusChip(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: _getStatusColor().withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        booking['status'] ?? 'Unknown',
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: _getStatusColor(),
              fontWeight: FontWeight.w500,
            ),
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
              ),
        ),
        const SizedBox(height: 8),
        ...children,
      ],
    );
  }

  Widget _buildInfoRow(BuildContext context, IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(
            icon,
            size: 16,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                      ),
                ),
                Text(
                  value,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor() {
    switch (booking['status']?.toLowerCase()) {
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