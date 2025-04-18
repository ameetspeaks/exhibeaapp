import 'package:flutter/material.dart';
import '../config/theme.dart';
import 'package:go_router/go_router.dart';

class BaseLayout extends StatelessWidget {
  final Widget child;
  final String userType;
  final List<BottomNavigationBarItem> bottomNavItems;
  final int currentIndex;
  final Function(int) onNavItemTapped;
  final bool showAppBar;
  final List<Widget>? actions;
  final String? title;

  const BaseLayout({
    Key? key,
    required this.child,
    required this.userType,
    required this.bottomNavItems,
    required this.currentIndex,
    required this.onNavItemTapped,
    this.showAppBar = true,
    this.actions,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: showAppBar ? AppBar(
        backgroundColor: AppTheme.getTheme(userType).primaryColor,
        title: title != null ? Text(
          title!,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ) : null,
        centerTitle: true,
        elevation: 0,
        actions: [
          ...?_getScreenActions(currentIndex, userType),
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: Colors.white),
            onPressed: () {
              // TODO: Implement notifications drawer
              Scaffold.of(context).openEndDrawer();
            },
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onSelected: (value) => _handleMenuSelection(context, value, userType),
            itemBuilder: (BuildContext context) => _getMenuItems(userType),
          ),
        ],
      ) : null,
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: AppTheme.getTheme(userType).primaryColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    radius: 30,
                    child: Icon(Icons.person, size: 30),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Notifications',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            // TODO: Add notification items
            ListTile(
              leading: const Icon(Icons.notifications_none),
              title: const Text('No new notifications'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: child,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          items: bottomNavItems,
          currentIndex: currentIndex,
          onTap: onNavItemTapped,
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          backgroundColor: AppTheme.surfaceColor,
          selectedItemColor: AppTheme.getTheme(userType).primaryColor,
          unselectedItemColor: AppTheme.textSecondaryColor,
        ),
      ),
    );
  }

  List<Widget>? _getScreenActions(int index, String userType) {
    switch (userType) {
      case 'exhibitor':
        // No search and filter buttons for any screen
        return null;
    }
    return null;
  }

  List<PopupMenuEntry<String>> _getMenuItems(String userType) {
    switch (userType) {
      case 'exhibitor':
        return [
          const PopupMenuItem<String>(
            value: 'create_exhibition',
            child: Text('Create Exhibition'),
          ),
          const PopupMenuItem<String>(
            value: 'settings',
            child: Text('Settings'),
          ),
          const PopupMenuItem<String>(
            value: 'help',
            child: Text('Help & Support'),
          ),
        ];
      case 'brand':
        return [
          const PopupMenuItem<String>(
            value: 'add_product',
            child: Text('Add Product'),
          ),
          const PopupMenuItem<String>(
            value: 'settings',
            child: Text('Settings'),
          ),
          const PopupMenuItem<String>(
            value: 'help',
            child: Text('Help & Support'),
          ),
        ];
      case 'shopper':
        return [
          const PopupMenuItem<String>(
            value: 'settings',
            child: Text('Settings'),
          ),
          const PopupMenuItem<String>(
            value: 'help',
            child: Text('Help & Support'),
          ),
        ];
      default:
        return [];
    }
  }

  void _handleMenuSelection(BuildContext context, String value, String userType) {
    switch (value) {
      case 'create_exhibition':
        context.go('/exhibitor/create-exhibition');
        break;
      case 'add_product':
        context.go('/brand/add-product');
        break;
      case 'settings':
        context.go('/$userType/settings');
        break;
      case 'help':
        context.go('/$userType/help');
        break;
    }
  }
} 