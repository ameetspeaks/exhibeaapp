import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BrandDetailsScreen extends StatefulWidget {
  final String brandId;

  const BrandDetailsScreen({
    super.key,
    required this.brandId,
  });

  @override
  State<BrandDetailsScreen> createState() => _BrandDetailsScreenState();
}

class _BrandDetailsScreenState extends State<BrandDetailsScreen> {
  bool _isLoading = false;
  bool _isFollowing = false;
  Map<String, dynamic>? _brandData;
  final Color primaryColor = const Color(0xFF389DF3);
  final Color accentColor = const Color(0xFFE97917);

  @override
  void initState() {
    super.initState();
    _loadBrandData();
  }

  Future<void> _loadBrandData() async {
    setState(() => _isLoading = true);

    try {
      // TODO: Implement brand data loading logic
      await Future.delayed(const Duration(seconds: 1)); // Simulated API call
      setState(() {
        _brandData = {
          'id': widget.brandId,
          'name': 'Fashion Forward',
          'category': 'Apparel',
          'description': 'A leading fashion brand known for innovative designs and sustainable practices. We create unique pieces that combine style and comfort.',
          'logo': 'https://images.unsplash.com/photo-1445205170230-053b83016050?w=500&auto=format&fit=crop&q=60',
          'coverImage': 'https://images.unsplash.com/photo-1523381210434-271e8be1f52b?w=500&auto=format&fit=crop&q=60',
          'products': [
            {
              'id': '1',
              'name': 'Summer Collection 2024',
              'image': 'https://images.unsplash.com/photo-1445205170230-053b83016050?w=500&auto=format&fit=crop&q=60',
              'price': '\$99.99',
            },
            {
              'id': '2',
              'name': 'Tech Fusion Jacket',
              'image': 'https://images.unsplash.com/photo-1523381210434-271e8be1f52b?w=500&auto=format&fit=crop&q=60',
              'price': '\$149.99',
            },
          ],
          'upcomingExhibitions': [
            {
              'id': '1',
              'name': 'Spring Fashion Show',
              'date': '2024-04-01',
              'location': 'Convention Center',
            },
            {
              'id': '2',
              'name': 'Tech Innovation Summit',
              'date': '2024-04-15',
              'location': 'Tech Hub',
            },
          ],
          'socialMedia': {
            'instagram': 'fashionforward',
            'facebook': 'fashionforward',
            'twitter': 'fashionforward',
          },
        };
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading brand data: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _toggleFollow() async {
    setState(() => _isLoading = true);
    try {
      // TODO: Implement API call to follow/unfollow brand
      await Future.delayed(const Duration(seconds: 1)); // Simulated API call
      setState(() => _isFollowing = !_isFollowing);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_isFollowing ? 'Brand followed successfully!' : 'Brand unfollowed'),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Brand Details'),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(_isFollowing ? Icons.person : Icons.person_add),
            onPressed: _isLoading ? null : _toggleFollow,
            tooltip: _isFollowing ? 'Unfollow Brand' : 'Follow Brand',
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _brandData == null
              ? const Center(child: Text('No data found'))
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Image.network(
                            _brandData!['coverImage'],
                            width: double.infinity,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                            bottom: -50,
                            left: 16,
                            child: Container(
                              width: 100,
                              height: 100,
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
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: ClipOval(
                                child: Image.network(
                                  _brandData!['logo'],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 60, 16, 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _brandData!['name'],
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: primaryColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                _brandData!['category'],
                                style: TextStyle(
                                  color: primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'About',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              _brandData!['description'],
                              style: const TextStyle(fontSize: 16),
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'Products',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            SizedBox(
                              height: 200,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: _brandData!['products'].length,
                                itemBuilder: (context, index) {
                                  final product = _brandData!['products'][index];
                                  return Container(
                                    width: 150,
                                    margin: const EdgeInsets.only(right: 16.0),
                                    child: Card(
                                      elevation: 2,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          ClipRRect(
                                            borderRadius: const BorderRadius.vertical(
                                              top: Radius.circular(12),
                                            ),
                                            child: Image.network(
                                              product['image'],
                                              width: 150,
                                              height: 150,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  product['name'],
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                                const SizedBox(height: 4),
                                                Text(
                                                  product['price'],
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: primaryColor,
                                                    fontWeight: FontWeight.bold,
                                                  ),
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
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'Upcoming Exhibitions',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            ..._brandData!['upcomingExhibitions'].map<Widget>((exhibition) {
                              return Card(
                                margin: const EdgeInsets.only(bottom: 8),
                                child: ListTile(
                                  onTap: () => context.go('/shopper/exhibitions/${exhibition['id']}'),
                                  title: Text(
                                    exhibition['name'],
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(exhibition['date']),
                                      Text(exhibition['location']),
                                    ],
                                  ),
                                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                                ),
                              );
                            }).toList(),
                            const SizedBox(height: 16),
                            const Text(
                              'Follow Us',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                _buildSocialButton(
                                  Icons.camera_alt,
                                  'Instagram',
                                  () {
                                    // TODO: Open Instagram
                                  },
                                ),
                                const SizedBox(width: 16),
                                _buildSocialButton(
                                  Icons.facebook,
                                  'Facebook',
                                  () {
                                    // TODO: Open Facebook
                                  },
                                ),
                                const SizedBox(width: 16),
                                _buildSocialButton(
                                  Icons.public,
                                  'Twitter',
                                  () {
                                    // TODO: Open Twitter
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }

  Widget _buildSocialButton(IconData icon, String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: primaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Icon(icon, color: primaryColor),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
} 