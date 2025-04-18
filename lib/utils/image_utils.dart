import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ImageUtils {
  static const String _baseAssetPath = 'assets/images';
  static const String _defaultExhibitionImage = '$_baseAssetPath/exhibitions/default_exhibition.jpg';
  static const String _defaultStallImage = '$_baseAssetPath/stalls/default_stall.jpg';
  static const String _defaultBrandImage = '$_baseAssetPath/brands/default_brand.jpg';
  static const String _defaultVenueImage = '$_baseAssetPath/venues/default_venue.jpg';

  static Widget buildNetworkImage({
    required String imageUrl,
    double? width,
    double? height,
    BoxFit fit = BoxFit.cover,
    String? placeholderAsset,
  }) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      fit: fit,
      placeholder: (context, url) => _buildPlaceholder(placeholderAsset),
      errorWidget: (context, url, error) => _buildErrorWidget(placeholderAsset),
    );
  }

  static Widget buildAssetImage({
    required String assetPath,
    double? width,
    double? height,
    BoxFit fit = BoxFit.cover,
  }) {
    return Image.asset(
      assetPath,
      width: width,
      height: height,
      fit: fit,
      errorBuilder: (context, error, stackTrace) => _buildErrorWidget(null),
    );
  }

  static Widget _buildPlaceholder(String? placeholderAsset) {
    return Container(
      color: Colors.grey[200],
      child: Center(
        child: CircularProgressIndicator(
          color: Colors.grey[400],
        ),
      ),
    );
  }

  static Widget _buildErrorWidget(String? placeholderAsset) {
    return Container(
      color: Colors.grey[200],
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              color: Colors.grey[400],
              size: 32,
            ),
            const SizedBox(height: 8),
            Text(
              'Failed to load image',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  static String getDefaultExhibitionImage() => _defaultExhibitionImage;
  static String getDefaultStallImage() => _defaultStallImage;
  static String getDefaultBrandImage() => _defaultBrandImage;
  static String getDefaultVenueImage() => _defaultVenueImage;
} 