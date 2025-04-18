import 'package:flutter/material.dart';
import '../config/theme.dart';

class SettingsScreen extends StatelessWidget {
  final String userType;

  const SettingsScreen({
    Key? key,
    required this.userType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: AppTheme.getTheme(userType).primaryColor,
      ),
      body: ListView(
        children: [
          _buildSection(
            title: 'Account Settings',
            children: [
              _buildSettingTile(
                icon: Icons.person_outline,
                title: 'Profile Information',
                onTap: () {
                  // TODO: Navigate to profile edit screen
                },
              ),
              _buildSettingTile(
                icon: Icons.lock_outline,
                title: 'Change Password',
                onTap: () {
                  // TODO: Navigate to password change screen
                },
              ),
              _buildSettingTile(
                icon: Icons.notifications_outlined,
                title: 'Notification Preferences',
                onTap: () {
                  // TODO: Navigate to notification settings
                },
              ),
            ],
          ),
          _buildSection(
            title: 'App Settings',
            children: [
              _buildSettingTile(
                icon: Icons.language,
                title: 'Language',
                onTap: () {
                  // TODO: Navigate to language settings
                },
              ),
              _buildSettingTile(
                icon: Icons.dark_mode_outlined,
                title: 'Theme',
                onTap: () {
                  // TODO: Navigate to theme settings
                },
              ),
            ],
          ),
          if (userType == 'exhibitor' || userType == 'brand')
            _buildSection(
              title: 'Business Settings',
              children: [
                _buildSettingTile(
                  icon: Icons.business_outlined,
                  title: 'Business Profile',
                  onTap: () {
                    // TODO: Navigate to business profile settings
                  },
                ),
                _buildSettingTile(
                  icon: Icons.payment_outlined,
                  title: 'Payment Settings',
                  onTap: () {
                    // TODO: Navigate to payment settings
                  },
                ),
              ],
            ),
          _buildSection(
            title: 'Support',
            children: [
              _buildSettingTile(
                icon: Icons.help_outline,
                title: 'Help Center',
                onTap: () {
                  // TODO: Navigate to help center
                },
              ),
              _buildSettingTile(
                icon: Icons.feedback_outlined,
                title: 'Send Feedback',
                onTap: () {
                  // TODO: Navigate to feedback form
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ...children,
        const Divider(),
      ],
    );
  }

  Widget _buildSettingTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
} 