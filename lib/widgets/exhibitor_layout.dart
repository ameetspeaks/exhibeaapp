import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ExhibitorLayout extends StatefulWidget {
  final Widget child;
  final int currentIndex;
  final bool showBackButton;
  final bool showAppBar;

  const ExhibitorLayout({
    super.key,
    required this.child,
    required this.currentIndex,
    this.showBackButton = false,
    this.showAppBar = true,
  });

  @override
  State<ExhibitorLayout> createState() => _ExhibitorLayoutState();
}

class _ExhibitorLayoutState extends State<ExhibitorLayout> {
  void _onItemTapped(int index) {
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
        context.go('/exhibitor/settings');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.showAppBar
          ? AppBar(
              automaticallyImplyLeading: widget.showBackButton,
              leading: widget.showBackButton
                  ? IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => context.pop(),
                    )
                  : null,
              title: Text(
                _getTitle(),
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              centerTitle: true,
              elevation: 0,
            )
          : null,
      body: widget.child,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: NavigationBar(
          selectedIndex: widget.currentIndex,
          onDestinationSelected: _onItemTapped,
          height: 70,
          elevation: 0,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          destinations: [
            NavigationDestination(
              icon: Icon(
                Icons.home_outlined,
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
              ),
              selectedIcon: Icon(
                Icons.home,
                color: Theme.of(context).colorScheme.primary,
              ),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(
                Icons.explore_outlined,
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
              ),
              selectedIcon: Icon(
                Icons.explore,
                color: Theme.of(context).colorScheme.primary,
              ),
              label: 'Exhibitions',
            ),
            NavigationDestination(
              icon: Icon(
                Icons.bookmark_outline,
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
              ),
              selectedIcon: Icon(
                Icons.bookmark,
                color: Theme.of(context).colorScheme.primary,
              ),
              label: 'Bookings',
            ),
            NavigationDestination(
              icon: Icon(
                Icons.settings_outlined,
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
              ),
              selectedIcon: Icon(
                Icons.settings,
                color: Theme.of(context).colorScheme.primary,
              ),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }

  String _getTitle() {
    switch (widget.currentIndex) {
      case 0:
        return 'Dashboard';
      case 1:
        return 'My Exhibitions';
      case 2:
        return 'Bookings';
      case 3:
        return 'Settings';
      default:
        return '';
    }
  }
} 