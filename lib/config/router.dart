import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../screens/splash_screen.dart';
import '../screens/onboarding_screen.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/register_screen.dart';
import '../screens/auth/forgot_password_screen.dart';
import '../screens/exhibitor/dashboard_screen.dart';
import '../screens/exhibitor/my_exhibitions_screen.dart';
import '../screens/exhibitor/stall_bookings_screen.dart';
import '../screens/exhibitor/exhibition_details_screen.dart';
import '../screens/exhibitor/stall_management_screen.dart';
import '../screens/exhibitor/create_exhibition_screen.dart';
import '../screens/exhibitor/edit_exhibition_screen.dart';
import '../screens/organizer/analytics_screen.dart';
import '../screens/brand/browse_exhibitions_screen.dart';
import '../screens/brand/my_bookings_screen.dart';
import '../screens/brand/my_products_screen.dart';
import '../screens/shopper/discover_exhibitions_screen.dart';
import '../screens/shopper/saved_events_screen.dart';
import '../screens/shopper/exclusive_deals_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: '/role-selection',
      builder: (context, state) => const RoleSelectionScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => RegisterScreen(
        role: state.uri.queryParameters['role'],
      ),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeScreen(),
    ),
    // Organizer routes
    GoRoute(
      path: '/create-exhibition',
      builder: (context, state) => const CreateExhibitionScreen(),
    ),
    GoRoute(
      path: '/my-exhibitions',
      builder: (context, state) => const MyExhibitionsScreen(),
    ),
    GoRoute(
      path: '/exhibition/:id',
      builder: (context, state) => ExhibitionDetailsScreen(
        exhibitionId: state.pathParameters['id']!,
      ),
    ),
    GoRoute(
      path: '/exhibition/:id/stalls',
      builder: (context, state) => StallManagementScreen(
        exhibitionId: state.pathParameters['id']!,
      ),
    ),
    GoRoute(
      path: '/exhibition/:id/analytics',
      builder: (context, state) => AnalyticsScreen(
        exhibitionId: state.pathParameters['id']!,
      ),
    ),
    GoRoute(
      path: '/stall-bookings',
      builder: (context, state) => const StallBookingsScreen(),
    ),
    // Brand routes
    GoRoute(
      path: '/browse-exhibitions',
      builder: (context, state) => const BrowseExhibitionsScreen(),
    ),
    GoRoute(
      path: '/my-bookings',
      builder: (context, state) => const MyBookingsScreen(),
    ),
    GoRoute(
      path: '/my-products',
      builder: (context, state) => const MyProductsScreen(),
    ),
    // Shopper routes
    GoRoute(
      path: '/discover-exhibitions',
      builder: (context, state) => const DiscoverExhibitionsScreen(),
    ),
    GoRoute(
      path: '/saved-events',
      builder: (context, state) => const SavedEventsScreen(),
    ),
    GoRoute(
      path: '/exclusive-deals',
      builder: (context, state) => const ExclusiveDealsScreen(),
    ),
  ],
  errorBuilder: (context, state) => Scaffold(
    body: Center(
      child: Text('Error: ${state.error}'),
    ),
  ),
); 