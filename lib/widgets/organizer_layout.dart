import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ExhibitorLayout extends StatefulWidget {
  final Widget child;

  const ExhibitorLayout({super.key, required this.child});

  @override
  State<ExhibitorLayout> createState() => _ExhibitorLayoutState();
}

class _ExhibitorLayoutState extends State<ExhibitorLayout> {
  int _currentIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

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
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: _onItemTapped,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          NavigationDestination(
            icon: Icon(Icons.event),
            label: 'Exhibitions',
          ),
          NavigationDestination(
            icon: Icon(Icons.book),
            label: 'Bookings',
          ),
        ],
      ),
    );
  }
} 