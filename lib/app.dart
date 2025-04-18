import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';
import 'config/theme.dart';
import 'screens/exhibitor/dashboard_screen.dart';
import 'screens/exhibitor/my_exhibitions_screen.dart';
import 'screens/exhibitor/stall_bookings_screen.dart';
import 'screens/exhibitor/exhibition_details_screen.dart';
import 'screens/exhibitor/stall_management_screen.dart';
import 'screens/exhibitor/create_exhibition_screen.dart';
import 'screens/exhibitor/edit_exhibition_screen.dart';
import 'screens/auth/shopper_login_screen.dart';
import 'screens/auth/brand_login_screen.dart';

final _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const RoleSelectionScreen(),
    ),
    GoRoute(
      path: '/shopper/login',
      builder: (context, state) => const ShopperLoginScreen(),
    ),
    GoRoute(
      path: '/brand/login',
      builder: (context, state) => const BrandLoginScreen(),
    ),
    GoRoute(
      path: '/organizer/dashboard',
      builder: (context, state) => const ExhibitorDashboardScreen(),
    ),
    GoRoute(
      path: '/organizer/my-exhibitions',
      builder: (context, state) => const MyExhibitionsScreen(),
    ),
    GoRoute(
      path: '/organizer/stall-bookings',
      builder: (context, state) => const StallBookingsScreen(),
    ),
  ],
);

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Welcome to Exhibae',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),
              _buildRoleCard(
                context,
                'Shopper',
                'Browse and shop at exhibitions',
                Icons.shopping_bag,
                AppTheme.shopperColor,
                () => context.go('/shopper/login'),
              ),
              const SizedBox(height: 24),
              _buildRoleCard(
                context,
                'Brand',
                'Manage your exhibitions and stalls',
                Icons.store,
                AppTheme.brandColor,
                () => context.go('/brand/login'),
              ),
              const SizedBox(height: 24),
              _buildRoleCard(
                context,
                'Organizer',
                'Create and manage exhibitions',
                Icons.event,
                AppTheme.exhibitorColor,
                () => context.go('/organizer/dashboard'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRoleCard(
    BuildContext context,
    String title,
    String description,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  size: 32,
                  color: color,
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey[400],
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Exhibae',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: AppTheme.exhibitorColor,
        // ... other theme settings ...
      ),
      routerConfig: _router,
    );
  }
} 