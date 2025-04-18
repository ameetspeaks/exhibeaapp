import 'package:flutter/material.dart';
import 'package:exhibae/models/exhibition.dart';

class ExhibitionDetailsCard extends StatelessWidget {
  final Exhibition exhibition;

  const ExhibitionDetailsCard({
    super.key,
    required this.exhibition,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Exhibition Details',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            _buildDetailRow(
              context,
              Icons.description,
              'Description',
              exhibition.description,
            ),
            const SizedBox(height: 12),
            _buildDetailRow(
              context,
              Icons.location_on,
              'Venue',
              exhibition.venue,
            ),
            const SizedBox(height: 12),
            _buildDetailRow(
              context,
              Icons.calendar_today,
              'Date',
              '${exhibition.startDate.toString().split(' ')[0]} - ${exhibition.endDate.toString().split(' ')[0]}',
            ),
            const SizedBox(height: 12),
            _buildDetailRow(
              context,
              Icons.store,
              'Stalls',
              '${exhibition.availableStalls} / ${exhibition.totalStalls} Available',
            ),
            const SizedBox(height: 12),
            _buildDetailRow(
              context,
              Icons.attach_money,
              'Price per Stall',
              '₹${exhibition.pricePerStall.toStringAsFixed(2)}',
            ),
          ],
        ),
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
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: Theme.of(context).colorScheme.primary,
            size: 20,
          ),
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
              const SizedBox(height: 2),
              Text(
                value,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }
} 