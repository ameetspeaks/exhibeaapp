import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'brand_bottom_nav.dart';

class BrandLayout extends StatelessWidget {
  final Widget child;

  const BrandLayout({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: const BrandBottomNav(),
    );
  }
} 