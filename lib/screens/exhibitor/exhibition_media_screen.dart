import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;
import 'dart:io';

class ExhibitionMediaScreen extends StatefulWidget {
  final String exhibitionId;

  const ExhibitionMediaScreen({Key? key, required this.exhibitionId}) : super(key: key);

  @override
  State<ExhibitionMediaScreen> createState() => _ExhibitionMediaScreenState();
}

class _ExhibitionMediaScreenState extends State<ExhibitionMediaScreen> {
  final ImagePicker _picker = ImagePicker();
  final _storage = FirebaseStorage.instance;
  String? _logoUrl;
  String? _coverUrl;
  final List<String> _galleryUrls = [];

  Future<void> _uploadImage(String type) async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image == null) return;

      final String fileName = path.basename(image.path);
      final String storagePath = 'exhibitions/${widget.exhibitionId}/$type/$fileName';
      
      final ref = _storage.ref().child(storagePath);
      await ref.putFile(File(image.path));
      final url = await ref.getDownloadURL();

      setState(() {
        if (type == 'logo') {
          _logoUrl = url;
        } else if (type == 'cover') {
          _coverUrl = url;
        } else {
          _galleryUrls.add(url);
        }
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error uploading image: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: const Text('Exhibition Media'),
            floating: true,
            pinned: true,
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _buildMediaSection(
                  'Logo',
                  _logoUrl,
                  () => _uploadImage('logo'),
                  'Upload a square logo image (recommended: 512x512)',
                ),
                const SizedBox(height: 24),
                _buildMediaSection(
                  'Cover Image',
                  _coverUrl,
                  () => _uploadImage('cover'),
                  'Upload a wide cover image (recommended: 1920x1080)',
                ),
                const SizedBox(height: 24),
                _buildGallerySection(),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMediaSection(
    String title,
    String? imageUrl,
    VoidCallback onUpload,
    String description,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 8),
        Text(
          description,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey[600],
              ),
        ),
        const SizedBox(height: 16),
        Container(
          height: 200,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(12),
            image: imageUrl != null
                ? DecorationImage(
                    image: NetworkImage(imageUrl),
                    fit: BoxFit.cover,
                  )
                : null,
          ),
          child: imageUrl == null
              ? Center(
                  child: ElevatedButton.icon(
                    onPressed: onUpload,
                    icon: const Icon(Icons.add_photo_alternate),
                    label: const Text('Upload Image'),
                  ),
                )
              : Stack(
                  children: [
                    Positioned(
                      right: 8,
                      top: 8,
                      child: IconButton(
                        onPressed: onUpload,
                        icon: const Icon(Icons.edit),
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ],
    );
  }

  Widget _buildGallerySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Media Gallery',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            TextButton.icon(
              onPressed: () => _uploadImage('gallery'),
              icon: const Icon(Icons.add),
              label: const Text('Add Photos'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: _galleryUrls.length,
          itemBuilder: (context, index) {
            return Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    _galleryUrls[index],
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  right: 4,
                  top: 4,
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        _galleryUrls.removeAt(index);
                      });
                    },
                    icon: const Icon(Icons.close),
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.all(4),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
} 