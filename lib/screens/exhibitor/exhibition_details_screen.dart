import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:exhibea/models/exhibition.dart';
import 'package:exhibea/widgets/action_button.dart';
import 'package:exhibea/widgets/booking_details_card.dart';
import 'package:exhibea/widgets/stats_card.dart';

class ExhibitionDetailsScreen extends StatelessWidget {
  final Exhibition exhibition;

  const ExhibitionDetailsScreen({
    super.key,
    required this.exhibition,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 200,
          pinned: true,
          title: const Text('Exhibition Details'),
          flexibleSpace: FlexibleSpaceBar(
            background: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(
                  exhibition.imageUrl,
                  fit: BoxFit.cover,
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.7),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 16,
                  left: 16,
                  right: 16,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        exhibition.name,
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: _getStatusColor(exhibition.status).withOpacity(0.9),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          exhibition.status,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              _buildStatsCard(context),
              const SizedBox(height: 24),
              _buildDetailsCard(context),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: _buildRecentBookings(context),
              ),
            ]),
          ),
        ),
      ],
    );
  }

  Widget _buildStatsCard(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 2),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Exhibition Stats',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 6),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
              childAspectRatio: 2.2,
              children: [
                _buildStatChip(
                  context,
                  'Total Bookings',
                  '${exhibition.totalStalls - exhibition.availableStalls}',
                  Icons.people_outline,
                  Colors.blue,
                ),
                _buildStatChip(
                  context,
                  'Revenue',
                  '₹${(exhibition.totalStalls - exhibition.availableStalls) * exhibition.pricePerStall}',
                  Icons.attach_money,
                  Colors.green,
                ),
                _buildStatChip(
                  context,
                  'Available Stalls',
                  '${exhibition.availableStalls}',
                  Icons.chair,
                  Colors.orange,
                ),
                _buildStatChip(
                  context,
                  'Total Stalls',
                  '${exhibition.totalStalls}',
                  Icons.grid_view,
                  Colors.purple,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatChip(
    BuildContext context,
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: color.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: color,
            size: 18,
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: color,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 1),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                  fontSize: 10,
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildDetailsCard(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Exhibition Details',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),
            _buildDetailRow(
              context,
              Icons.location_on,
              'Venue',
              exhibition.venue,
            ),
            const SizedBox(height: 8),
            _buildDetailRow(
              context,
              Icons.calendar_today,
              'Date',
              '${_formatDate(exhibition.startDate)} - ${_formatDate(exhibition.endDate)}',
            ),
            const SizedBox(height: 8),
            _buildDetailRow(
              context,
              Icons.description,
              'Description',
              exhibition.description,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: _buildActionButton(
                    context,
                    Icons.edit,
                    'Edit',
                    () => context.push('/exhibitor/exhibitions/${exhibition.id}/form'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildActionButton(
                    context,
                    Icons.settings,
                    'Settings',
                    () => context.push('/exhibitor/exhibitions/${exhibition.id}/settings'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: _buildActionButton(
                    context,
                    Icons.grid_view,
                    'Layout',
                    () => context.push('/exhibitor/exhibitions/${exhibition.id}/layout'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildActionButton(
                    context,
                    Icons.people,
                    'Stalls',
                    () => context.push('/exhibitor/exhibitions/${exhibition.id}/stalls'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context,
    IconData icon,
    String label,
    VoidCallback onPressed,
  ) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 22),
          const SizedBox(height: 6),
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(
    BuildContext context,
    IconData icon,
    String label,
    String value,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 20,
          color: Theme.of(context).colorScheme.primary,
        ),
        const SizedBox(width: 12),
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
              const SizedBox(height: 4),
              Text(
                value,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRecentBookings(BuildContext context) {
    // TODO: Replace with actual bookings data from Firestore
    final sampleBookings = [
      {
        'id': 'BK001',
        'status': 'Confirmed',
        'customerName': 'John Doe',
        'customerEmail': 'john@example.com',
        'customerPhone': '+1 234 567 8901',
        'stallNumber': 'A1',
        'amount': '2500',
        'paymentMethod': 'Credit Card',
      },
      {
        'id': 'BK002',
        'status': 'Pending',
        'customerName': 'Jane Smith',
        'customerEmail': 'jane@example.com',
        'customerPhone': '+1 234 567 8902',
        'stallNumber': 'B2',
        'amount': '3000',
        'paymentMethod': 'PayPal',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Recent Bookings',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            TextButton(
              onPressed: () {
                // TODO: Navigate to all bookings
              },
              child: const Text('View All'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        if (sampleBookings.isEmpty)
          const Center(
            child: Text('No bookings yet'),
          )
        else
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: sampleBookings.length,
            separatorBuilder: (context, index) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              final booking = sampleBookings[index];
              return BookingDetailsCard(
                booking: {
                  'id': booking['id']?.toString() ?? 'N/A',
                  'status': booking['status'] ?? 'Unknown',
                  'customer': booking['customerName'] ?? 'Unknown',
                  'email': booking['customerEmail'] ?? 'N/A',
                  'phone': booking['customerPhone'] ?? 'N/A',
                  'exhibition': exhibition.name,
                  'venue': exhibition.venue,
                  'date': _formatDate(exhibition.startDate),
                  'time': '10:00 AM', // TODO: Replace with actual time
                  'stall': booking['stallNumber']?.toString() ?? 'N/A',
                  'amount': booking['amount']?.toString() ?? '₹0',
                  'paymentMethod': booking['paymentMethod'] ?? 'N/A',
                },
              );
            },
          ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'completed':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }
} 