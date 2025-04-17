import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final Map<String, dynamic> _userProfile = {
    'name': 'John Doe',
    'email': 'john.doe@example.com',
    'phone': '+1 234 567 8900',
    'location': 'New York, USA',
    'interests': ['Fashion', 'Technology', 'Art'],
    'joinedDate': 'January 2024',
    'profileImage': 'https://picsum.photos/200/200?random=1',
  };

  bool _notificationsEnabled = true;
  bool _darkMode = false;
  String _selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 200,
          pinned: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.pop(),
          ),
          flexibleSpace: FlexibleSpaceBar(
            background: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(
                  _userProfile['profileImage'],
                  fit: BoxFit.cover,
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.7),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile Info
                Center(
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(_userProfile['profileImage']),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        _userProfile['name'],
                        style: theme.textTheme.headlineSmall,
                      ),
                      Text(
                        _userProfile['email'],
                        style: theme.textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                // Account Settings
                Text(
                  'Account Settings',
                  style: theme.textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                _buildSettingsCard(
                  children: [
                    _buildSettingTile(
                      icon: Icons.person_outline,
                      title: 'Edit Profile',
                      onTap: () {
                        context.push('/shopper/profile/edit');
                      },
                    ),
                    _buildSettingTile(
                      icon: Icons.location_on_outlined,
                      title: 'Location',
                      subtitle: _userProfile['location'],
                      onTap: () {
                        // TODO: Implement location settings
                      },
                    ),
                    _buildSettingTile(
                      icon: Icons.language_outlined,
                      title: 'Language',
                      subtitle: _selectedLanguage,
                      onTap: () {
                        _showLanguagePicker();
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Preferences
                Text(
                  'Preferences',
                  style: theme.textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                _buildSettingsCard(
                  children: [
                    _buildSwitchTile(
                      icon: Icons.notifications_outlined,
                      title: 'Notifications',
                      value: _notificationsEnabled,
                      onChanged: (value) {
                        setState(() => _notificationsEnabled = value);
                      },
                    ),
                    _buildSwitchTile(
                      icon: Icons.dark_mode_outlined,
                      title: 'Dark Mode',
                      value: _darkMode,
                      onChanged: (value) {
                        setState(() => _darkMode = value);
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Interests
                Text(
                  'Interests',
                  style: theme.textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _userProfile['interests'].map<Widget>((interest) {
                    return Chip(
                      label: Text(interest),
                      onDeleted: () {
                        setState(() {
                          _userProfile['interests'].remove(interest);
                        });
                      },
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () {
                    // TODO: Implement add interest
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Add Interest'),
                ),
                const SizedBox(height: 32),

                // Logout Button
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      // TODO: Implement logout
                      context.go('/shopper/login');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.colorScheme.error,
                      foregroundColor: theme.colorScheme.onError,
                    ),
                    child: const Text('Logout'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSettingsCard({required List<Widget> children}) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: children,
      ),
    );
  }

  Widget _buildSettingTile({
    required IconData icon,
    required String title,
    String? subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle) : null,
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }

  Widget _buildSwitchTile({
    required IconData icon,
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return SwitchListTile(
      secondary: Icon(icon),
      title: Text(title),
      value: value,
      onChanged: onChanged,
    );
  }

  void _showLanguagePicker() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Select Language',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              ListTile(
                title: const Text('English'),
                trailing: _selectedLanguage == 'English'
                    ? const Icon(Icons.check)
                    : null,
                onTap: () {
                  setState(() => _selectedLanguage = 'English');
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Spanish'),
                trailing: _selectedLanguage == 'Spanish'
                    ? const Icon(Icons.check)
                    : null,
                onTap: () {
                  setState(() => _selectedLanguage = 'Spanish');
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('French'),
                trailing: _selectedLanguage == 'French'
                    ? const Icon(Icons.check)
                    : null,
                onTap: () {
                  setState(() => _selectedLanguage = 'French');
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
} 