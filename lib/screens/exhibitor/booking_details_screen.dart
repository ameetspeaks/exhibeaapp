import 'package:flutter/material.dart';
import 'package:exhibea/widgets/booking_details_card.dart';
import 'package:exhibea/widgets/stats_card.dart';
import 'package:exhibea/widgets/action_button.dart';

class BookingDetailsScreen extends StatelessWidget {
  final String bookingId;

  const BookingDetailsScreen({
    super.key,
    required this.bookingId,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.all(16),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              BookingDetailsCard(
                booking: {
                  'id': bookingId,
                  'customer': 'John Doe',
                  'email': 'john.doe@example.com',
                  'phone': '+1 234 567 8900',
                  'exhibition': 'Tech Expo 2024',
                  'venue': 'Convention Center, New York',
                  'date': '25 Mar 2024',
                  'time': '10:00 AM - 6:00 PM',
                  'stall': 'A-12',
                  'status': 'Confirmed',
                  'amount': '₹24,000',
                  'paymentMethod': 'Credit Card',
                },
              ),
              const SizedBox(height: 16),
              StatsCard(
                title: 'Booking Stats',
                stats: {
                  'Duration': '8 hours',
                  'Visitors': '2',
                  'Revenue': '₹24,000',
                },
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ActionButton(
                      icon: Icons.message_outlined,
                      label: 'Message',
                      onPressed: () {
                        // TODO: Implement message functionality
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ActionButton(
                      icon: Icons.check_circle_outline,
                      label: 'Check In',
                      onPressed: () {
                        // TODO: Implement check-in functionality
                      },
                    ),
                  ),
                ],
              ),
            ]),
          ),
        ),
      ],
    );
  }
} 