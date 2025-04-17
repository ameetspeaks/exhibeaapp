import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BrandProfileScreen extends StatefulWidget {
  const BrandProfileScreen({super.key});

  @override
  State<BrandProfileScreen> createState() => _BrandProfileScreenState();
}

class _BrandProfileScreenState extends State<BrandProfileScreen> {
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  
  // Form fields
  String _name = 'John Doe';
  String _email = 'john@example.com';
  String _phone = '+91 9876543210';
  String _companyName = 'Tech Solutions Inc.';
  String _companyAddress = '123 Business Street, City, State';
  String _companyWebsite = 'www.techsolutions.com';
  String _companyDescription = 'Leading provider of innovative tech solutions';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionTitle('Profile Picture'),
                    const SizedBox(height: 16),
                    Center(
                      child: Stack(
                        children: [
                          const CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage(
                              'https://via.placeholder.com/100',
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    _buildSectionTitle('Personal Information'),
                    const SizedBox(height: 16),
                    TextFormField(
                      initialValue: _name,
                      decoration: const InputDecoration(
                        labelText: 'Name',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                      onSaved: (value) => _name = value!,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      initialValue: _email,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!value.contains('@')) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                      onSaved: (value) => _email = value!,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      initialValue: _phone,
                      decoration: const InputDecoration(
                        labelText: 'Phone Number',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your phone number';
                        }
                        return null;
                      },
                      onSaved: (value) => _phone = value!,
                    ),
                    const SizedBox(height: 24),
                    _buildSectionTitle('Company Information'),
                    const SizedBox(height: 16),
                    TextFormField(
                      initialValue: _companyName,
                      decoration: const InputDecoration(
                        labelText: 'Company Name',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter company name';
                        }
                        return null;
                      },
                      onSaved: (value) => _companyName = value!,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      initialValue: _companyAddress,
                      decoration: const InputDecoration(
                        labelText: 'Company Address',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter company address';
                        }
                        return null;
                      },
                      onSaved: (value) => _companyAddress = value!,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      initialValue: _companyWebsite,
                      decoration: const InputDecoration(
                        labelText: 'Company Website',
                        border: OutlineInputBorder(),
                      ),
                      onSaved: (value) => _companyWebsite = value!,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      initialValue: _companyDescription,
                      decoration: const InputDecoration(
                        labelText: 'Company Description',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 3,
                      onSaved: (value) => _companyDescription = value!,
                    ),
                    const SizedBox(height: 24),
                    _buildSectionTitle('Settings'),
                    const SizedBox(height: 16),
                    SwitchListTile(
                      title: const Text('Email Notifications'),
                      subtitle: const Text('Receive email notifications about bookings and updates'),
                      value: true,
                      onChanged: (value) {
                        // TODO: Implement notification settings
                      },
                    ),
                    SwitchListTile(
                      title: const Text('Push Notifications'),
                      subtitle: const Text('Receive push notifications on your device'),
                      value: true,
                      onChanged: (value) {
                        // TODO: Implement notification settings
                      },
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _saveProfile,
                        child: const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text('Save Changes'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    _formKey.currentState!.save();
    setState(() => _isLoading = true);

    try {
      // TODO: Implement profile update logic
      await Future.delayed(const Duration(seconds: 2)); // Simulated API call
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile updated successfully')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error updating profile: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _logout() async {
    setState(() => _isLoading = true);

    try {
      // TODO: Implement logout logic
      await Future.delayed(const Duration(seconds: 1)); // Simulated API call
      
      if (mounted) {
        context.go('/login');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error logging out: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }
} 