import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../utils/placeholder_image.dart';
import '../../services/auth_service.dart';

class BrandProfileScreen extends StatefulWidget {
  const BrandProfileScreen({super.key});

  @override
  State<BrandProfileScreen> createState() => _BrandProfileScreenState();
}

class _BrandProfileScreenState extends State<BrandProfileScreen> {
  bool _isLoading = false;
  bool _isEditing = false;
  Map<String, dynamic>? _brandProfile;
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _websiteController = TextEditingController();
  final _addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadBrandProfile();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _websiteController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  Future<void> _loadBrandProfile() async {
    setState(() => _isLoading = true);

    try {
      // TODO: Implement brand profile loading logic
      await Future.delayed(const Duration(seconds: 1)); // Simulated API call
      setState(() {
        _brandProfile = {
          'name': 'TechStyle',
          'description': 'Leading technology and fashion brand',
          'logo': 'assets/images/logo_placeholder.jpg',
          'banner': 'assets/images/banner_placeholder.jpg',
          'contact': {
            'email': 'contact@techstyle.com',
            'phone': '+91 9876543210',
            'website': 'www.techstyle.com',
            'address': '123 Tech Street, Innovation City',
          },
          'socialMedia': {
            'instagram': '@techstyle',
            'facebook': 'TechStyle',
            'twitter': '@techstyle',
          },
          'lookbook': [
            {
              'id': '1',
              'title': 'Spring Collection 2024',
              'image': 'https://images.unsplash.com/photo-1445205170230-053b83016050?w=500&auto=format&fit=crop&q=60',
              'description': 'Our latest spring collection featuring innovative designs',
            },
            {
              'id': '2',
              'title': 'Tech Fusion',
              'image': 'https://images.unsplash.com/photo-1523381210434-271e8be1f52b?w=500&auto=format&fit=crop&q=60',
              'description': 'Technology meets fashion in our signature collection',
            },
            {
              'id': '3',
              'title': 'Urban Explorer',
              'image': 'https://images.unsplash.com/photo-1529139574466-a303027c1d8b?w=500&auto=format&fit=crop&q=60',
              'description': 'Urban-inspired designs for the modern explorer',
            },
          ],
          'mediaGallery': [
            {
              'id': '1',
              'type': 'image',
              'url': 'https://images.unsplash.com/photo-1490481651871-ab68de25d43d?w=500&auto=format&fit=crop&q=60',
              'caption': 'Product Launch Event',
            },
            {
              'id': '2',
              'type': 'image',
              'url': 'https://images.unsplash.com/photo-1511795409834-43254d3b3a04?w=500&auto=format&fit=crop&q=60',
              'caption': 'Fashion Show 2024',
            },
            {
              'id': '3',
              'type': 'image',
              'url': 'https://images.unsplash.com/photo-1526170375885-4d8ecf77b99f?w=500&auto=format&fit=crop&q=60',
              'caption': 'Store Opening',
            },
            {
              'id': '4',
              'type': 'image',
              'url': 'https://images.unsplash.com/photo-1515886657613-9f3515b0c78f?w=500&auto=format&fit=crop&q=60',
              'caption': 'Behind the Scenes',
            },
          ],
          'stats': {
            'exhibitions': 12,
            'products': 45,
            'followers': 1200,
            'rating': 4.8,
          },
          'categories': ['Fashion', 'Technology', 'Lifestyle'],
          'awards': [
            {
              'title': 'Best Innovation 2023',
              'issuer': 'Tech Awards',
              'year': '2023',
            },
            {
              'title': 'Design Excellence',
              'issuer': 'Fashion Council',
              'year': '2022',
            },
          ],
        };
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading brand profile: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _startEditing() {
    _nameController.text = _brandProfile!['name'];
    _descriptionController.text = _brandProfile!['description'];
    _emailController.text = _brandProfile!['contact']['email'];
    _phoneController.text = _brandProfile!['contact']['phone'];
    _websiteController.text = _brandProfile!['contact']['website'];
    _addressController.text = _brandProfile!['contact']['address'];
    setState(() => _isEditing = true);
  }

  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _brandProfile = {
          ..._brandProfile!,
          'name': _nameController.text,
          'description': _descriptionController.text,
          'contact': {
            ..._brandProfile!['contact'],
            'email': _emailController.text,
            'phone': _phoneController.text,
            'website': _websiteController.text,
            'address': _addressController.text,
          },
        };
        _isEditing = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully')),
      );
    }
  }

  Future<void> _handleLogout() async {
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Logout'),
          ),
        ],
      ),
    );

    if (shouldLogout == true) {
      try {
        await AuthService().signOut();
        if (mounted) {
          context.go('/login');
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to logout: $e')),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_isEditing) {
          final shouldDiscard = await showDialog<bool>(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Discard Changes'),
              content: const Text('Are you sure you want to discard your changes?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, true),
                  child: const Text('Discard'),
                ),
              ],
            ),
          );
          return shouldDiscard ?? false;
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Brand Profile'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              if (_isEditing) {
                _showDiscardChangesDialog();
              } else {
                context.pop();
              }
            },
          ),
          actions: [
            if (!_isEditing)
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: _startEditing,
              )
            else
              TextButton(
                onPressed: _saveProfile,
                child: const Text('Save'),
              ),
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: _handleLogout,
              tooltip: 'Logout',
            ),
          ],
        ),
        body: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : _brandProfile == null
                ? const Center(child: Text('No profile data found'))
                : LayoutBuilder(
                    builder: (context, constraints) {
                      return SingleChildScrollView(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: constraints.maxHeight,
                          ),
                          child: SafeArea(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    Container(
                                      height: 200,
                                      width: double.infinity,
                                      child: const PlaceholderImage(
                                        height: 200,
                                        backgroundColor: Colors.grey,
                                        icon: Icons.image,
                                        iconColor: Colors.white,
                                      ),
                                    ),
                                    Positioned(
                                      left: 16,
                                      bottom: -40,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: Colors.white,
                                            width: 4,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withOpacity(0.1),
                                              blurRadius: 8,
                                              offset: const Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                        child: const CircleAvatar(
                                          radius: 40,
                                          backgroundColor: Colors.grey,
                                          child: Icon(
                                            Icons.store,
                                            size: 40,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 50),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                  child: Form(
                                    key: _formKey,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        if (_isEditing)
                                          TextFormField(
                                            controller: _nameController,
                                            decoration: const InputDecoration(
                                              labelText: 'Brand Name',
                                              border: OutlineInputBorder(),
                                            ),
                                            validator: (value) {
                                              if (value == null || value.isEmpty) {
                                                return 'Please enter brand name';
                                              }
                                              return null;
                                            },
                                          )
                                        else
                                          Text(
                                            _brandProfile!['name'],
                                            style: const TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        const SizedBox(height: 8),
                                        if (_isEditing)
                                          TextFormField(
                                            controller: _descriptionController,
                                            decoration: const InputDecoration(
                                              labelText: 'Description',
                                              border: OutlineInputBorder(),
                                            ),
                                            maxLines: 3,
                                            validator: (value) {
                                              if (value == null || value.isEmpty) {
                                                return 'Please enter description';
                                              }
                                              return null;
                                            },
                                          )
                                        else
                                          Text(_brandProfile!['description']),
                                        const SizedBox(height: 24),
                                        _buildSectionTitle('Brand Stats'),
                                        _buildStatsCard(),
                                        const SizedBox(height: 24),
                                        _buildSectionTitle('Categories'),
                                        _buildCategoriesChips(),
                                        const SizedBox(height: 24),
                                        _buildSectionTitle('Contact Information'),
                                        if (_isEditing)
                                          Column(
                                            children: [
                                              TextFormField(
                                                controller: _emailController,
                                                decoration: const InputDecoration(
                                                  labelText: 'Email',
                                                  border: OutlineInputBorder(),
                                                ),
                                                validator: (value) {
                                                  if (value == null || value.isEmpty) {
                                                    return 'Please enter email';
                                                  }
                                                  return null;
                                                },
                                              ),
                                              const SizedBox(height: 8),
                                              TextFormField(
                                                controller: _phoneController,
                                                decoration: const InputDecoration(
                                                  labelText: 'Phone',
                                                  border: OutlineInputBorder(),
                                                ),
                                                validator: (value) {
                                                  if (value == null || value.isEmpty) {
                                                    return 'Please enter phone number';
                                                  }
                                                  return null;
                                                },
                                              ),
                                              const SizedBox(height: 8),
                                              TextFormField(
                                                controller: _websiteController,
                                                decoration: const InputDecoration(
                                                  labelText: 'Website',
                                                  border: OutlineInputBorder(),
                                                ),
                                                validator: (value) {
                                                  if (value == null || value.isEmpty) {
                                                    return 'Please enter website';
                                                  }
                                                  return null;
                                                },
                                              ),
                                              const SizedBox(height: 8),
                                              TextFormField(
                                                controller: _addressController,
                                                decoration: const InputDecoration(
                                                  labelText: 'Address',
                                                  border: OutlineInputBorder(),
                                                ),
                                                validator: (value) {
                                                  if (value == null || value.isEmpty) {
                                                    return 'Please enter address';
                                                  }
                                                  return null;
                                                },
                                              ),
                                            ],
                                          )
                                        else
                                          _buildInfoCard(
                                            content: Column(
                                              children: [
                                                _buildContactRow(
                                                  icon: Icons.email,
                                                  text: _brandProfile!['contact']['email'],
                                                ),
                                                const SizedBox(height: 8),
                                                _buildContactRow(
                                                  icon: Icons.phone,
                                                  text: _brandProfile!['contact']['phone'],
                                                ),
                                                const SizedBox(height: 8),
                                                _buildContactRow(
                                                  icon: Icons.language,
                                                  text: _brandProfile!['contact']['website'],
                                                ),
                                                const SizedBox(height: 8),
                                                _buildContactRow(
                                                  icon: Icons.location_on,
                                                  text: _brandProfile!['contact']['address'],
                                                ),
                                              ],
                                            ),
                                          ),
                                        const SizedBox(height: 24),
                                        _buildSectionTitle('Social Media'),
                                        _buildInfoCard(
                                          content: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              _buildSocialIcon(
                                                icon: Icons.camera_alt,
                                                onTap: () {
                                                  // TODO: Open Instagram
                                                },
                                              ),
                                              _buildSocialIcon(
                                                icon: Icons.facebook,
                                                onTap: () {
                                                  // TODO: Open Facebook
                                                },
                                              ),
                                              _buildSocialIcon(
                                                icon: Icons.public,
                                                onTap: () {
                                                  // TODO: Open Twitter
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 24),
                                        _buildSectionTitle('Awards & Recognition'),
                                        _buildAwardsList(),
                                        const SizedBox(height: 24),
                                        _buildSectionTitle('LookBook'),
                                        _buildLookBookSection(),
                                        const SizedBox(height: 24),
                                        _buildSectionTitle('Media Gallery'),
                                        _buildMediaGallery(),
                                        const SizedBox(height: 24),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
      ),
    );
  }

  Widget _buildStatsCard() {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildStatItem(
              icon: Icons.event,
              label: 'Exhibitions',
              value: _brandProfile!['stats']['exhibitions'].toString(),
            ),
            _buildStatItem(
              icon: Icons.shopping_bag,
              label: 'Products',
              value: _brandProfile!['stats']['products'].toString(),
            ),
            _buildStatItem(
              icon: Icons.people,
              label: 'Followers',
              value: _brandProfile!['stats']['followers'].toString(),
            ),
            _buildStatItem(
              icon: Icons.star,
              label: 'Rating',
              value: _brandProfile!['stats']['rating'].toString(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 20),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 10),
        ),
      ],
    );
  }

  Widget _buildCategoriesChips() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: _brandProfile!['categories'].map<Widget>((category) {
        return Chip(
          label: Text(category),
          backgroundColor: Colors.blue[100],
        );
      }).toList(),
    );
  }

  Widget _buildAwardsList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _brandProfile!['awards'].length,
      itemBuilder: (context, index) {
        final award = _brandProfile!['awards'][index];
        return ListTile(
          leading: const Icon(Icons.emoji_events),
          title: Text(award['title']),
          subtitle: Text('${award['issuer']} - ${award['year']}'),
        );
      },
    );
  }

  Widget _buildLookBookSection() {
    return SizedBox(
      height: 220,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _brandProfile!['lookbook'].length,
        itemBuilder: (context, index) {
          final look = _brandProfile!['lookbook'][index];
          return Container(
            width: 180,
            margin: const EdgeInsets.only(right: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    look['image'],
                    width: 180,
                    height: 180,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        width: 180,
                        height: 180,
                        color: Colors.grey[200],
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 180,
                        height: 180,
                        color: Colors.grey[200],
                        child: const Icon(
                          Icons.error_outline,
                          color: Colors.red,
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 8),
                Flexible(
                  child: Text(
                    look['title'],
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: 4),
                Flexible(
                  child: Text(
                    look['description'],
                    style: const TextStyle(fontSize: 12),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildMediaGallery() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: _brandProfile!['mediaGallery'].length,
      itemBuilder: (context, index) {
        final media = _brandProfile!['mediaGallery'][index];
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.grey[200],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
                child: Image.network(
                  media['url'],
                  height: 120,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      height: 120,
                      color: Colors.grey[200],
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 120,
                      color: Colors.grey[200],
                      child: const Icon(
                        Icons.error_outline,
                        color: Colors.red,
                      ),
                    );
                  },
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    media['caption'],
                    style: const TextStyle(fontSize: 12),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildInfoCard({required Widget content}) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: content,
      ),
    );
  }

  Widget _buildContactRow({required IconData icon, required String text}) {
    return Row(
      children: [
        Icon(icon, size: 20),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 14),
          ),
        ),
      ],
    );
  }

  Widget _buildSocialIcon({required IconData icon, required VoidCallback onTap}) {
    return IconButton(
      icon: Icon(icon),
      onPressed: onTap,
      iconSize: 28,
    );
  }

  void _showMediaDetails(Map<String, dynamic> media) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const PlaceholderImage(
              height: 300,
              backgroundColor: Colors.grey,
              icon: Icons.photo_library,
              iconColor: Colors.white,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                media['caption'],
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showDiscardChangesDialog() async {
    final shouldDiscard = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Discard Changes'),
        content: const Text('Are you sure you want to discard your changes?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Discard'),
          ),
        ],
      ),
    );

    if (shouldDiscard == true && mounted) {
      setState(() => _isEditing = false);
      context.pop();
    }
  }
} 