import 'package:flutter/material.dart';
import 'package:exhibea/models/stall.dart';

class StallCard extends StatelessWidget {
  final Stall stall;
  final VoidCallback? onTap;

  const StallCard({
    Key? key,
    required this.stall,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Stall ${stall.number}',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  _buildStatusChip(context),
                ],
              ),
              const SizedBox(height: 8),
              _buildInfoRow(context, Icons.straighten, stall.size),
              const SizedBox(height: 4),
              _buildInfoRow(context, Icons.attach_money, '₹${stall.price}'),
              const SizedBox(height: 4),
              _buildInfoRow(context, Icons.category, stall.type),
              if (stall.brand != null) ...[
                const SizedBox(height: 4),
                _buildInfoRow(context, Icons.business, stall.brand!),
              ],
            ],
          ),
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
        stall.status,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: _getStatusColor(),
              fontWeight: FontWeight.w500,
            ),
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, IconData icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
              ),
        ),
      ],
    );
  }

  Color _getStatusColor() {
    switch (stall.status.toLowerCase()) {
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
} 