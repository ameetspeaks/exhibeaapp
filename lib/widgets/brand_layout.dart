import 'package:flutter/material.dart';
import '../config/theme.dart';
import 'package:go_router/go_router.dart';
import 'base_layout.dart';

class BrandLayout extends StatefulWidget {
  final Widget child;

  const BrandLayout({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  State<BrandLayout> createState() => _BrandLayoutState();
}

class _BrandLayoutState extends State<BrandLayout> {
  final List<BottomNavigationBarItem> _bottomNavItems = const [
    BottomNavigationBarItem(
      icon: Icon(Icons.dashboard),
      label: 'Dashboard',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.explore),
      label: 'Exhibitions',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.book),
      label: 'Bookings',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: 'Profile',
    ),
  ];

  void _onNavItemTapped(int index) {
    switch (index) {
      case 0:
        context.go('/exhibitor/dashboard');
        break;
      case 1:
        context.go('/exhibitor/exhibitions');
        break;
      case 2:
        context.go('/exhibitor/bookings');
        break;
      case 3:
        context.go('/exhibitor/profile');
        break;
    }
  }

  String _getTitle(String path) {
    if (path.contains('/exhibitor/dashboard')) {
      return 'Dashboard';
    } else if (path.contains('/exhibitor/exhibitions')) {
      return 'My Exhibitions';
    } else if (path.contains('/exhibitor/bookings')) {
      return 'Bookings';
    } else if (path.contains('/exhibitor/profile')) {
      return 'Profile';
    } else if (path.contains('/exhibitor/create-exhibition')) {
      return 'Create Exhibition';
    } else if (path.contains('/exhibitor/edit-exhibition')) {
      return 'Edit Exhibition';
    } else if (path.contains('/exhibitor/exhibition/') && path.contains('/stalls')) {
      return 'Stall Management';
    } else if (path.contains('/exhibitor/exhibition/')) {
      return 'Exhibition Details';
    } else if (path.contains('/exhibitor/stall-bookings')) {
      return 'Stall Bookings';
    } else if (path.contains('/exhibitor/exhibitions/') && path.contains('/bookings/')) {
      return 'Booking Details';
    } else if (path.contains('/exhibitor/settings')) {
      return 'Settings';
    } else if (path.contains('/exhibitor/help')) {
      return 'Help & Support';
    }
    return '';
  }

  int _getCurrentIndex(String path) {
    if (path.contains('/exhibitor/dashboard')) {
      return 0;
    } else if (path.contains('/exhibitor/exhibitions')) {
      return 1;
    } else if (path.contains('/exhibitor/bookings')) {
      return 2;
    } else if (path.contains('/exhibitor/profile')) {
      return 3;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final path = GoRouterState.of(context).uri.path;
    final title = _getTitle(path);
    final currentIndex = _getCurrentIndex(path);

    return BaseLayout(
      userType: 'exhibitor',
      title: title,
      bottomNavItems: _bottomNavItems,
      currentIndex: currentIndex,
      onNavItemTapped: _onNavItemTapped,
      child: widget.child,
    );
  }
} 