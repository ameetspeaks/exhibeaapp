import 'package:flutter/material.dart';
import '../models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import '../models/user_type.dart';

class AuthService extends ChangeNotifier {
  static bool useMockAuth = true; // Always true for now
  static const String _userKey = 'current_user';
  UserModel? _currentUser;
  bool _isAuthenticated = false;
  UserType? _userType;

  bool get isAuthenticated => _isAuthenticated;
  UserType? get userType => _userType;
  UserModel? get currentUser => _currentUser;

  // Mock user data
  final List<Map<String, dynamic>> _mockUsers = [
    {
      'id': '1',
      'email': 'exhibitor@test.com',
      'password': 'password123',
      'name': 'Exhibitor User',
      'userType': 'exhibitor',
      'role': 'exhibitor',
      'phone': '+91 9876543210',
      'createdAt': DateTime.now().toIso8601String(),
      'updatedAt': DateTime.now().toIso8601String(),
    },
    {
      'id': '2',
      'email': 'brand@test.com',
      'password': 'password123',
      'name': 'Brand User',
      'userType': 'brand',
      'role': 'brand',
      'phone': '+91 9876543210',
      'createdAt': DateTime.now().toIso8601String(),
      'updatedAt': DateTime.now().toIso8601String(),
    },
    {
      'id': '3',
      'email': 'shopper@test.com',
      'password': 'password123',
      'name': 'Shopper User',
      'userType': 'shopper',
      'role': 'shopper',
      'phone': '+91 9876543210',
      'createdAt': DateTime.now().toIso8601String(),
      'updatedAt': DateTime.now().toIso8601String(),
    },
  ];

  // Mock user for development
  static final UserModel _mockUser = UserModel(
    id: 'mock_user_id',
    email: 'mock@example.com',
    name: 'Mock User',
    userType: 'brand',
    role: 'brand',
    phone: '+91 9876543210',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );

  // Get current user
  Future<UserModel?> getCurrentUser() async {
    if (_currentUser != null) return _currentUser;

    try {
      final prefs = await SharedPreferences.getInstance();
      final userJson = prefs.getString(_userKey);
      if (userJson != null) {
        final userMap = Map<String, dynamic>.from(json.decode(userJson));
        _currentUser = UserModel.fromJson(userMap);
        _isAuthenticated = true;
        _userType = _getUserTypeFromString(_currentUser!.userType);
        notifyListeners();
        return _currentUser;
      }
    } catch (e) {
      debugPrint('Error getting current user: $e');
    }
    return null;
  }

  Future<void> signIn({
    required String email,
    required String password,
    required UserType userType,
  }) async {
    try {
      // Simulate API delay
      await Future.delayed(const Duration(seconds: 1));

      // Find matching user
      final user = _mockUsers.firstWhere(
        (user) => 
          user['email'] == email && 
          user['password'] == password &&
          user['userType'] == userType.name,
        orElse: () => throw Exception('Invalid credentials'),
      );

      _currentUser = UserModel.fromJson(user);
      _isAuthenticated = true;
      _userType = userType;
      
      // Save user to shared preferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_userKey, json.encode(user));

      notifyListeners();
    } catch (e) {
      _currentUser = null;
      _isAuthenticated = false;
      _userType = null;
      notifyListeners();
      rethrow;
    }
  }

  Future<void> signOut() async {
    try {
      // Clear current user
      _currentUser = null;
      _isAuthenticated = false;
      _userType = null;
      
      // Remove user from shared preferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_userKey);

      notifyListeners();
    } catch (e) {
      debugPrint('Error signing out: $e');
      rethrow;
    }
  }

  // Create user with email and password
  Future<UserModel> createUser({
    required String email,
    required String password,
    required String name,
    required UserType userType,
  }) async {
    // Simulate API delay
    await Future.delayed(const Duration(seconds: 1));

    // Check if email already exists
    if (_mockUsers.any((user) => user['email'] == email)) {
      throw Exception('Email already in use');
    }

    // Create new user
    final newUser = {
      'id': (_mockUsers.length + 1).toString(),
      'email': email,
      'password': password,
      'name': name,
      'userType': userType.name,
      'role': userType.name,
      'phone': null,
      'createdAt': DateTime.now().toIso8601String(),
      'updatedAt': DateTime.now().toIso8601String(),
    };

    // In a real app, this would be saved to a database
    _mockUsers.add(newUser);
    _currentUser = UserModel.fromJson(newUser);
    _isAuthenticated = true;
    _userType = userType;
    notifyListeners();
    return _currentUser!;
  }

  UserType? _getUserTypeFromString(String? userType) {
    if (userType == null) return null;
    return UserType.values.firstWhere(
      (type) => type.name == userType.toLowerCase(),
      orElse: () => UserType.shopper,
    );
  }

  // Reset password
  Future<void> resetPassword(String email) async {
    // Simulate API delay
    await Future.delayed(const Duration(seconds: 1));
    
    // Mock validation
    if (email.isEmpty) {
      throw 'Please enter your email';
    }
  }

  // Update user profile
  Future<void> updateUserProfile(UserModel user) async {
    // Simulate API delay
    await Future.delayed(const Duration(seconds: 1));
    _currentUser = user;
  }
} 