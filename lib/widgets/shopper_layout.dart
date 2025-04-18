import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'base_layout.dart';

class ShopperLayout extends StatefulWidget {
  final Widget child;

  const ShopperLayout({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  State<ShopperLayout> createState() => _ShopperLayoutState();
}

class _ShopperLayoutState extends State<ShopperLayout> {
  int _currentIndex = 0;

  final List<BottomNavigationBarItem> _bottomNavItems = const [
    BottomNavigationBarItem(
      icon: Icon(Icons.explore),
      label: 'Discover',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.favorite_border),
      label: 'Saved',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person_outline),
      label: 'Profile',
    ),
  ];

  void _onNavItemTapped(int index) {
    setState(() => _currentIndex = index);
    switch (index) {
      case 0:
        context.go('/shopper/exhibitions');
        break;
      case 1:
        context.go('/shopper/saved');
        break;
      case 2:
        context.go('/shopper/profile');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      userType: 'shopper',
      child: widget.child,
      bottomNavItems: _bottomNavItems,
      currentIndex: _currentIndex,
      onNavItemTapped: _onNavItemTapped,
    );
  }
} 