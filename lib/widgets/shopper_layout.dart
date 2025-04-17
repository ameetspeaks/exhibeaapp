import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ShopperLayout extends StatefulWidget {
  final Widget child;

  const ShopperLayout({super.key, required this.child});

  @override
  State<ShopperLayout> createState() => _ShopperLayoutState();
}

class _ShopperLayoutState extends State<ShopperLayout> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final isLoginScreen = GoRouterState.of(context).uri.path == '/shopper/login';
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: widget.child,
      ),
      bottomNavigationBar: isLoginScreen
          ? null
          : Container(
              decoration: BoxDecoration(
                color: theme.scaffoldBackgroundColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 26, red: 0, green: 0, blue: 0),
                    blurRadius: 10,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: BottomNavigationBar(
                currentIndex: _currentIndex,
                onTap: (index) {
                  setState(() => _currentIndex = index);
                  switch (index) {
                    case 0:
                      context.go('/shopper/dashboard');
                      break;
                    case 1:
                      context.go('/shopper/exhibitions');
                      break;
                    case 2:
                      context.go('/shopper/saved');
                      break;
                    case 3:
                      context.go('/shopper/profile');
                      break;
                  }
                },
                type: BottomNavigationBarType.fixed,
                selectedItemColor: theme.primaryColor,
                unselectedItemColor: theme.unselectedWidgetColor,
                selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home_outlined),
                    activeIcon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.event_outlined),
                    activeIcon: Icon(Icons.event),
                    label: 'Exhibitions',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.favorite_border),
                    activeIcon: Icon(Icons.favorite),
                    label: 'Saved',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person_outline),
                    activeIcon: Icon(Icons.person),
                    label: 'Profile',
                  ),
                ],
              ),
            ),
    );
  }
} 