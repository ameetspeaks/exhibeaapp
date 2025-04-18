import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../utils/placeholder_image.dart';
import '../../services/auth_service.dart';
import '../../services/brand_service.dart';
import '../../models/brand_model.dart';
import 'package:url_launcher/url_launcher.dart';

class BrandProfileScreen extends StatefulWidget {
  const BrandProfileScreen({super.key});

  @override
  State<BrandProfileScreen> createState() => _BrandProfileScreenState();
}

class _BrandProfileScreenState extends State<BrandProfileScreen> {
  bool _isLoading = false;
  bool _isEditing = false;
  BrandModel? _brandProfile;
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _websiteController = TextEditingController();
  final _addressController = TextEditingController();
  final BrandService _brandService = BrandService();

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
      final profileData = await _brandService.getBrandProfile();
      setState(() {
        _brandProfile = BrandModel.fromJson(profileData);
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
    if (_brandProfile != null) {
      _nameController.text = _brandProfile!.name;
      _descriptionController.text = _brandProfile!.description;
      _emailController.text = _brandProfile!.contact.email;
      _phoneController.text = _brandProfile!.contact.phone;
      _websiteController.text = _brandProfile!.contact.website;
      _addressController.text = _brandProfile!.contact.address;
      setState(() => _isEditing = true);
    }
  }

  Future<void> _saveProfile() async {
    if (_formKey.currentState!.validate() && _brandProfile != null) {
      setState(() => _isLoading = true);

      try {
        final updatedProfile = _brandProfile!.toJson();
        updatedProfile['name'] = _nameController.text;
        updatedProfile['description'] = _descriptionController.text;
        updatedProfile['contact'] = {
          ..._brandProfile!.contact.toJson(),
          'email': _emailController.text,
          'phone': _phoneController.text,
          'website': _websiteController.text,
          'address': _addressController.text,
        };

        final savedProfile = await _brandService.updateBrandProfile(updatedProfile);
        setState(() {
          _brandProfile = BrandModel.fromJson(savedProfile);
          _isEditing = false;
        });

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
                                            _brandProfile!.name,
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
                                          Text(_brandProfile!.description),
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
                                                  text: _brandProfile!.contact.email,
                                                ),
                                                const SizedBox(height: 8),
                                                _buildContactRow(
                                                  icon: Icons.phone,
                                                  text: _brandProfile!.contact.phone,
                                                ),
                                                const SizedBox(height: 8),
                                                _buildContactRow(
                                                  icon: Icons.language,
                                                  text: _brandProfile!.contact.website,
                                                ),
                                                const SizedBox(height: 8),
                                                _buildContactRow(
                                                  icon: Icons.location_on,
                                                  text: _brandProfile!.contact.address,
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
              value: _brandProfile!.stats.exhibitions.toString(),
            ),
            _buildStatItem(
              icon: Icons.shopping_bag,
              label: 'Products',
              value: _brandProfile!.stats.products.toString(),
            ),
            _buildStatItem(
              icon: Icons.people,
              label: 'Followers',
              value: _brandProfile!.stats.followers.toString(),
            ),
            _buildStatItem(
              icon: Icons.star,
              label: 'Rating',
              value: _brandProfile!.stats.rating.toString(),
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
      children: _brandProfile!.categories.map<Widget>((category) {
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
      itemCount: _brandProfile!.awards.length,
      itemBuilder: (context, index) {
        final award = _brandProfile!.awards[index];
        return ListTile(
          leading: const Icon(Icons.emoji_events),
          title: Text(award.title),
          subtitle: Text('${award.issuer} - ${award.year}'),
        );
      },
    );
  }

  Widget _buildLookBookSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('LookBook'),
        if (_brandProfile!.lookbook.isEmpty)
          const Center(child: Text('No LookBook items available'))
        else
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.8,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: _brandProfile!.lookbook.length,
            itemBuilder: (context, index) {
              final look = _brandProfile!.lookbook[index];
              return Card(
                child: InkWell(
                  onTap: () => _openLookBookItem(look),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Image.network(
                          look['image'] ?? '',
                          fit: BoxFit.cover,
                          width: double.infinity,
                          errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              look['title'] ?? '',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              look['description'] ?? '',
                              style: const TextStyle(fontSize: 12),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
      ],
    );
  }

  Widget _buildMediaGallery() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Media Gallery'),
        if (_brandProfile!.mediaGallery.isEmpty)
          const Center(child: Text('No media items available'))
        else
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1,
              crossAxisSpacing: 4,
              mainAxisSpacing: 4,
            ),
            itemCount: _brandProfile!.mediaGallery.length,
            itemBuilder: (context, index) {
              final media = _brandProfile!.mediaGallery[index];
              return Card(
                child: InkWell(
                  onTap: () => _openMediaItem(media),
                  child: Stack(
                    children: [
                      Image.network(
                        media['url'] ?? '',
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                        errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
                      ),
                      if (media['caption'] != null && media['caption'].isNotEmpty)
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            color: Colors.black54,
                            child: Text(
                              media['caption'] ?? '',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
      ],
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

  Future<void> _openLookBookItem(Map<String, dynamic> look) async {
    if (look['type'] == 'pdf') {
      final Uri url = Uri.parse(look['url'] ?? '');
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Could not open PDF')),
          );
        }
      }
    } else {
      if (mounted) {
        showDialog(
          context: context,
          builder: (context) => Dialog(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.network(
                  look['image'] ?? '',
                  fit: BoxFit.contain,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        look['title'] ?? '',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(look['description'] ?? ''),
                    ],
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
    }
  }

  void _openMediaItem(Map<String, dynamic> media) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.network(
              media['url'] ?? '',
              fit: BoxFit.contain,
            ),
            if (media['caption'] != null && media['caption'].isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(media['caption'] ?? ''),
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
} 