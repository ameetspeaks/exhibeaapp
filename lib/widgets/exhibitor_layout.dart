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

  @override
  Widget build(BuildContext context) {
    // Hide bottom navigation bar on login screen
    final isLoginScreen = ModalRoute.of(context)?.settings.name == '/auth/exhibitor';
    
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: isLoginScreen
          ? null
          : BottomNavigationBar(
              currentIndex: _currentIndex,
              onTap: (index) {
                setState(() => _currentIndex = index);
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
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.dashboard),
                  label: 'Dashboard',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.event),
                  label: 'Exhibitions',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.book_online),
                  label: 'Bookings',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Profile',
                ),
              ],
            ),
    );
  }
} 