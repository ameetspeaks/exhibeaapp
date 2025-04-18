import 'package:flutter/material.dart';
import '../config/theme.dart';

class HelpScreen extends StatelessWidget {
  final String userType;

  const HelpScreen({
    Key? key,
    required this.userType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help & Support'),
        backgroundColor: AppTheme.getTheme(userType).primaryColor,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildSection(
            title: 'Frequently Asked Questions',
            children: _getFAQs(userType),
          ),
          const SizedBox(height: 24),
          _buildSection(
            title: 'Contact Support',
            children: [
              _buildContactOption(
                icon: Icons.email_outlined,
                title: 'Email Support',
                subtitle: 'support@exhibitionapp.com',
                onTap: () {
                  // TODO: Open email client
                },
              ),
              _buildContactOption(
                icon: Icons.phone_outlined,
                title: 'Phone Support',
                subtitle: '+1 (555) 123-4567',
                onTap: () {
                  // TODO: Open phone dialer
                },
              ),
              _buildContactOption(
                icon: Icons.chat_outlined,
                title: 'Live Chat',
                subtitle: 'Available 24/7',
                onTap: () {
                  // TODO: Open chat interface
                },
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildSection(
            title: 'Resources',
            children: [
              _buildResourceTile(
                title: 'User Guide',
                onTap: () {
                  // TODO: Open user guide
                },
              ),
              _buildResourceTile(
                title: 'Video Tutorials',
                onTap: () {
                  // TODO: Open video tutorials
                },
              ),
              _buildResourceTile(
                title: 'Community Forum',
                onTap: () {
                  // TODO: Open forum
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Widget> _getFAQs(String userType) {
    switch (userType) {
      case 'exhibitor':
        return [
          _buildFAQItem(
            question: 'How do I create a new exhibition?',
            answer: 'Navigate to the Exhibitions tab and tap the + button to create a new exhibition.',
          ),
          _buildFAQItem(
            question: 'How do I manage stall bookings?',
            answer: 'Go to the exhibition details and select the "Stall Bookings" option to view and manage bookings.',
          ),
          _buildFAQItem(
            question: 'How do I edit my exhibition details?',
            answer: 'Open the exhibition details and tap the edit button to modify exhibition information.',
          ),
        ];
      case 'brand':
        return [
          _buildFAQItem(
            question: 'How do I book a stall?',
            answer: 'Browse available exhibitions and select a stall to book. Follow the booking process to complete your reservation.',
          ),
          _buildFAQItem(
            question: 'How do I manage my products?',
            answer: 'Go to the Products tab to add, edit, or remove products from your catalog.',
          ),
          _buildFAQItem(
            question: 'How do I update my brand profile?',
            answer: 'Navigate to your profile and select "Edit Profile" to update your brand information.',
          ),
        ];
      case 'shopper':
        return [
          _buildFAQItem(
            question: 'How do I find exhibitions?',
            answer: 'Use the Discover tab to browse available exhibitions and filter by location or category.',
          ),
          _buildFAQItem(
            question: 'How do I save exhibitions?',
            answer: 'Tap the heart icon on any exhibition to save it to your favorites.',
          ),
          _buildFAQItem(
            question: 'How do I contact exhibitors?',
            answer: 'Visit the exhibition details page and use the contact button to reach out to exhibitors.',
          ),
        ];
      default:
        return [];
    }
  }

  Widget _buildSection({
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        ...children,
      ],
    );
  }

  Widget _buildFAQItem({
    required String question,
    required String answer,
  }) {
    return ExpansionTile(
      title: Text(
        question,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
        ),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(answer),
        ),
      ],
    );
  }

  Widget _buildContactOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }

  Widget _buildResourceTile({
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
} 