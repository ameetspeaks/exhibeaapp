import 'package:flutter/material.dart';
import '../models/brand_model.dart';

class BrandService {
  static final BrandService _instance = BrandService._internal();
  factory BrandService() => _instance;
  BrandService._internal();

  // Mock data for development
  final Map<String, dynamic> _mockBrandData = {
    'id': '1',
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

  Future<Map<String, dynamic>> getBrandProfile() async {
    // Simulate API call delay
    await Future.delayed(const Duration(seconds: 1));
    return _mockBrandData;
  }

  Future<Map<String, dynamic>> updateBrandProfile(Map<String, dynamic> updatedProfile) async {
    // Simulate API call delay
    await Future.delayed(const Duration(seconds: 1));
    _mockBrandData.updateAll((key, value) => updatedProfile[key] ?? value);
    return _mockBrandData;
  }

  Future<List<Map<String, dynamic>>> getActiveBookings() async {
    // Simulate API call delay
    await Future.delayed(const Duration(seconds: 1));
    return [
      {
        'id': '1',
        'exhibition': 'Tech Expo 2024',
        'stall': 'A-101',
        'date': '2024-03-15',
        'status': 'Confirmed',
      },
      {
        'id': '2',
        'exhibition': 'Fashion Week',
        'stall': 'B-203',
        'date': '2024-03-20',
        'status': 'Confirmed',
      },
    ];
  }

  Future<List<Map<String, dynamic>>> getUpcomingExhibitions() async {
    // Simulate API call delay
    await Future.delayed(const Duration(seconds: 1));
    return [
      {
        'id': '1',
        'name': 'Spring Fashion Show',
        'date': '2024-04-01',
        'location': 'Convention Center',
        'availableStalls': 12,
      },
      {
        'id': '2',
        'name': 'Tech Innovation Summit',
        'date': '2024-04-15',
        'location': 'Tech Hub',
        'availableStalls': 8,
      },
    ];
  }

  Future<List<Map<String, dynamic>>> getLookBook() async {
    // Simulate API call delay
    await Future.delayed(const Duration(seconds: 1));
    return [
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
    ];
  }
} 