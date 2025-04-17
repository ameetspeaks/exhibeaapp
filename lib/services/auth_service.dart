import 'package:flutter/material.dart';
import '../models/user_model.dart';

class AuthService {
  static bool useMockAuth = true; // Always true for now

  // Mock user data
  final List<Map<String, dynamic>> _mockUsers = [
    {
      'id': '1',
      'email': 'exhibitor@example.com',
      'password': 'exhibitor123',
      'name': 'Exhibitor User',
      'userType': 'exhibitor',
      'role': 'exhibitor',
      'phone': '+91 9876543210',
      'createdAt': DateTime.now().toIso8601String(),
      'updatedAt': DateTime.now().toIso8601String(),
    },
    {
      'id': '2',
      'email': 'brand@example.com',
      'password': 'brand123',
      'name': 'Brand User',
      'userType': 'brand',
      'role': 'brand',
      'phone': '+91 9876543210',
      'createdAt': DateTime.now().toIso8601String(),
      'updatedAt': DateTime.now().toIso8601String(),
    },
    {
      'id': '3',
      'email': 'shopper@example.com',
      'password': 'shopper123',
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
    // Simulate API delay
    await Future.delayed(const Duration(seconds: 1));
    
    // In a real app, this would return the current user from storage
    return null;
  }

  // Sign in with email and password
  Future<UserModel> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    // Simulate API delay
    await Future.delayed(const Duration(seconds: 1));

    // Find matching user
    final user = _mockUsers.firstWhere(
      (user) => user['email'] == email && user['password'] == password,
      orElse: () => throw 'Invalid email or password',
    );

    return UserModel.fromJson(user);
  }

  // Create user with email and password
  Future<UserModel> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
    required String userType,
    required String role,
  }) async {
    // Simulate API delay
    await Future.delayed(const Duration(seconds: 1));

    // Check if email already exists
    if (_mockUsers.any((user) => user['email'] == email)) {
      throw 'Email already in use';
    }

    // Create new user
    final newUser = {
      'id': (_mockUsers.length + 1).toString(),
      'email': email,
      'password': password,
      'name': name,
      'userType': userType,
      'role': role,
      'phone': null,
      'createdAt': DateTime.now().toIso8601String(),
      'updatedAt': DateTime.now().toIso8601String(),
    };

    // In a real app, this would be saved to a database
    _mockUsers.add(newUser);

    return UserModel.fromJson(newUser);
  }

  // Sign out
  Future<void> signOut() async {
    // Simulate API delay
    await Future.delayed(const Duration(seconds: 1));
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
  }
} 