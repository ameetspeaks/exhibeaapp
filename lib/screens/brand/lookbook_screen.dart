import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

class LookBookScreen extends StatefulWidget {
  const LookBookScreen({super.key});

  @override
  State<LookBookScreen> createState() => _LookBookScreenState();
}

class _LookBookScreenState extends State<LookBookScreen> {
  bool _isLoading = false;
  List<Map<String, dynamic>>? _lookbookItems;
  final Color brandColor = const Color(0xFF389DF3);
  final Color buttonColor = const Color(0xFFE97917);
  final Color textColor = const Color(0xFFFFFFFF);

  @override
  void initState() {
    super.initState();
    _loadLookBookItems();
  }

  Future<void> _loadLookBookItems() async {
    setState(() => _isLoading = true);

    try {
      // TODO: Implement LookBook items loading logic
      await Future.delayed(const Duration(seconds: 1)); // Simulated API call
      setState(() {
        _lookbookItems = [
          {
            'id': '1',
            'title': 'Spring Collection 2024',
            'type': 'image',
            'url': 'https://images.unsplash.com/photo-1445205170230-053b83016050?w=500&auto=format&fit=crop&q=60',
            'description': 'Our latest spring collection featuring innovative designs',
          },
          {
            'id': '2',
            'title': 'Tech Fusion Catalog',
            'type': 'pdf',
            'url': 'https://example.com/catalog.pdf',
            'description': 'Download our complete product catalog',
          },
          {
            'id': '3',
            'title': 'Summer Collection',
            'type': 'image',
            'url': 'https://images.unsplash.com/photo-1523381210434-271e8be1f52b?w=500&auto=format&fit=crop&q=60',
            'description': 'Preview our upcoming summer collection',
          },
          {
            'id': '4',
            'title': 'Winter Collection',
            'type': 'image',
            'url': 'https://images.unsplash.com/photo-1529139574466-a303027c1d8b?w=500&auto=format&fit=crop&q=60',
            'description': 'Our winter collection featuring warm and cozy designs',
          },
        ];
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading LookBook items: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _openLookBookItem(Map<String, dynamic> look) async {
    if (look['type'] == 'pdf') {
      final Uri url = Uri.parse(look['url']);
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
                  look['url'],
                  fit: BoxFit.contain,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        look['title'],
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(look['description']),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LookBook'),
        backgroundColor: brandColor,
        foregroundColor: textColor,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _lookbookItems == null
              ? const Center(child: Text('No LookBook items found'))
              : GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.8,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: _lookbookItems!.length,
                  itemBuilder: (context, index) {
                    final look = _lookbookItems![index];
                    return Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: InkWell(
                        onTap: () => _openLookBookItem(look),
                        borderRadius: BorderRadius.circular(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                                  child: look['type'] == 'image'
                                      ? Image.network(
                                          look['url'],
                                          height: 200,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                          loadingBuilder: (context, child, loadingProgress) {
                                            if (loadingProgress == null) return child;
                                            return Container(
                                              height: 200,
                                              color: Colors.grey[200],
                                              child: const Center(
                                                child: CircularProgressIndicator(),
                                              ),
                                            );
                                          },
                                          errorBuilder: (context, error, stackTrace) {
                                            return Container(
                                              height: 200,
                                              color: Colors.grey[200],
                                              child: const Icon(
                                                Icons.error_outline,
                                                color: Colors.red,
                                              ),
                                            );
                                          },
                                        )
                                      : Container(
                                          height: 200,
                                          color: Colors.grey[200],
                                          child: const Icon(
                                            Icons.picture_as_pdf,
                                            size: 48,
                                            color: Colors.red,
                                          ),
                                        ),
                                ),
                                if (look['type'] == 'pdf')
                                  Positioned(
                                    top: 8,
                                    right: 8,
                                    child: Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: const Text(
                                        'PDF',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    look['title'],
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    look['description'],
                                    style: const TextStyle(fontSize: 14),
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
    );
  }
} 