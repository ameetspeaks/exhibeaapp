import 'package:flutter/material.dart';

class ExhibitionSettingsScreen extends StatefulWidget {
  final String exhibitionId;

  const ExhibitionSettingsScreen({
    super.key,
    required this.exhibitionId,
  });

  @override
  State<ExhibitionSettingsScreen> createState() => _ExhibitionSettingsScreenState();
}

class _ExhibitionSettingsScreenState extends State<ExhibitionSettingsScreen> {
  bool _isLoading = true;
  Map<String, dynamic>? _settings;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));
      
      setState(() {
        _settings = {
          'notificationEnabled': true,
          'emailNotifications': true,
          'pushNotifications': true,
          'bookingConfirmation': true,
          'paymentReminders': true,
          'stallAvailability': true,
          'defaultCurrency': 'USD',
          'timezone': 'UTC+0',
          'language': 'English',
        };
        _isLoading = false;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load settings: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Settings'),
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _buildSectionTitle('Notifications'),
                _buildNotificationSettings(),
                const SizedBox(height: 24),
                _buildSectionTitle('General Settings'),
                _buildGeneralSettings(),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildNotificationSettings() {
    return Card(
      child: Column(
        children: [
          SwitchListTile(
            title: const Text('Enable Notifications'),
            value: _settings!['notificationEnabled'],
            onChanged: (value) {
              setState(() {
                _settings!['notificationEnabled'] = value;
              });
            },
          ),
          SwitchListTile(
            title: const Text('Email Notifications'),
            value: _settings!['emailNotifications'],
            onChanged: (value) {
              setState(() {
                _settings!['emailNotifications'] = value;
              });
            },
          ),
          SwitchListTile(
            title: const Text('Push Notifications'),
            value: _settings!['pushNotifications'],
            onChanged: (value) {
              setState(() {
                _settings!['pushNotifications'] = value;
              });
            },
          ),
          SwitchListTile(
            title: const Text('Booking Confirmations'),
            value: _settings!['bookingConfirmation'],
            onChanged: (value) {
              setState(() {
                _settings!['bookingConfirmation'] = value;
              });
            },
          ),
          SwitchListTile(
            title: const Text('Payment Reminders'),
            value: _settings!['paymentReminders'],
            onChanged: (value) {
              setState(() {
                _settings!['paymentReminders'] = value;
              });
            },
          ),
          SwitchListTile(
            title: const Text('Stall Availability Alerts'),
            value: _settings!['stallAvailability'],
            onChanged: (value) {
              setState(() {
                _settings!['stallAvailability'] = value;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildGeneralSettings() {
    return Card(
      child: Column(
        children: [
          ListTile(
            title: const Text('Default Currency'),
            subtitle: Text(_settings!['defaultCurrency']),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // TODO: Show currency picker
            },
          ),
          ListTile(
            title: const Text('Timezone'),
            subtitle: Text(_settings!['timezone']),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // TODO: Show timezone picker
            },
          ),
          ListTile(
            title: const Text('Language'),
            subtitle: Text(_settings!['language']),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // TODO: Show language picker
            },
          ),
        ],
      ),
    );
  }
} 