import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LogoutService {
  static void logout(BuildContext context, String userType) {
    // Clear any user data or tokens here
    // For now, just navigate to login
    context.go('/login');
  }
} 