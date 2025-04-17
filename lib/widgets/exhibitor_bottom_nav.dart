import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ExhibitorBottomNav extends StatelessWidget {
  const ExhibitorBottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;
    
    return NavigationBar(
      selectedIndex: _getSelectedIndex(location),
      onDestinationSelected: (index) => _onItemTapped(context, index),
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.dashboard_outlined),
          selectedIcon: Icon(Icons.dashboard),
          label: 'Dashboard',
        ),
        NavigationDestination(
          icon: Icon(Icons.explore_outlined),
          selectedIcon: Icon(Icons.explore),
          label: 'Exhibitions',
        ),
        NavigationDestination(
          icon: Icon(Icons.bookmark_outline),
          selectedIcon: Icon(Icons.bookmark),
          label: 'Bookings',
        ),
        NavigationDestination(
          icon: Icon(Icons.person_outline),
          selectedIcon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }

  int _getSelectedIndex(String location) {
    if (location.startsWith('/organizer/exhibitions')) {
      return 1;
    } else if (location.startsWith('/organizer/bookings')) {
      return 2;
    } else if (location.startsWith('/organizer/profile')) {
      return 3;
    }
    return 0; // Default to dashboard
  }

  void _onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/organizer');
        break;
      case 1:
        context.go('/organizer/exhibitions');
        break;
      case 2:
        context.go('/organizer/bookings');
        break;
      case 3:
        context.go('/organizer/profile');
        break;
    }
  }
} 