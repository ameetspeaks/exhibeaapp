import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../screens/splash_screen.dart';
import '../screens/login_screen.dart';
import '../screens/register_screen.dart';
import '../screens/shopper/exhibitions_screen.dart';
import '../screens/shopper/saved_items_screen.dart';
import '../screens/shopper/profile_screen.dart';
import '../screens/exhibitor/dashboard_screen.dart';
import '../screens/exhibitor/my_exhibitions_screen.dart';
import '../screens/exhibitor/stall_bookings_screen.dart';
import '../screens/exhibitor/exhibition_details_screen.dart';
import '../screens/exhibitor/stall_management_screen.dart';
import '../screens/exhibitor/create_exhibition_screen.dart';
import '../screens/exhibitor/edit_exhibition_screen.dart';
import '../screens/exhibitor/exhibition_form_screen.dart';
import '../screens/exhibitor/booking_details_screen.dart';
import '../screens/exhibitor/brands_screen.dart';
import '../screens/exhibitor/bookings_screen.dart';
import '../screens/exhibitor/exhibition_settings_screen.dart';
import '../screens/exhibitor/stall_layout_screen.dart';
import '../screens/settings_screen.dart';
import '../screens/help_screen.dart';
import '../widgets/shopper_layout.dart';
import '../widgets/brand_layout.dart';
import '../screens/home_screen.dart';
import '../screens/shopper/brand_screen.dart';
import '../screens/shopper/exhibitor_screen.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
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
    ShellRoute(
      builder: (context, state, child) => ShopperLayout(child: child),
      routes: [
        GoRoute(
          path: '/shopper',
          redirect: (context, state) => '/shopper/exhibitions',
        ),
        GoRoute(
          path: '/shopper/exhibitions',
          builder: (context, state) => const ExhibitionsScreen(),
        ),
        GoRoute(
          path: '/shopper/saved',
          builder: (context, state) => const SavedItemsScreen(),
        ),
        GoRoute(
          path: '/shopper/profile',
          builder: (context, state) => const ProfileScreen(),
        ),
        GoRoute(
          path: '/shopper/brand/:id',
          builder: (context, state) => BrandScreen(
            brandId: state.pathParameters['id']!,
          ),
        ),
        GoRoute(
          path: '/shopper/exhibitor/:id',
          builder: (context, state) => ExhibitorScreen(
            exhibitorId: state.pathParameters['id']!,
          ),
        ),
        GoRoute(
          path: '/shopper/settings',
          builder: (context, state) => SettingsScreen(userType: 'shopper'),
        ),
        GoRoute(
          path: '/shopper/help',
          builder: (context, state) => HelpScreen(userType: 'shopper'),
        ),
      ],
    ),
    ShellRoute(
      builder: (context, state, child) => BrandLayout(child: child),
      routes: [
        GoRoute(
          path: '/exhibitor',
          redirect: (context, state) => '/exhibitor/exhibitions',
        ),
        GoRoute(
          path: '/exhibitor/dashboard',
          builder: (context, state) => const DashboardScreen(),
        ),
        GoRoute(
          path: '/exhibitor/exhibitions',
          builder: (context, state) => const MyExhibitionsScreen(),
        ),
        GoRoute(
          path: '/exhibitor/bookings',
          builder: (context, state) => const BookingsScreen(),
        ),
        GoRoute(
          path: '/exhibitor/brands',
          builder: (context, state) => const BrandsScreen(),
        ),
        GoRoute(
          path: '/exhibitor/brands/:id',
          builder: (context, state) => BrandScreen(
            brandId: state.pathParameters['id']!,
          ),
        ),
        GoRoute(
          path: '/exhibitor/my-exhibitions',
          redirect: (context, state) => '/exhibitor/exhibitions',
        ),
        GoRoute(
          path: '/exhibitor/stall-bookings/:exhibitionId',
          builder: (context, state) => StallBookingsScreen(
            exhibitionId: state.pathParameters['exhibitionId']!,
          ),
        ),
        GoRoute(
          path: '/exhibitor/exhibition/:id',
          builder: (context, state) => ExhibitionDetailsScreen(
            exhibitionId: state.pathParameters['id']!,
          ),
        ),
        GoRoute(
          path: '/exhibitor/exhibition/:id/stalls',
          builder: (context, state) => StallManagementScreen(
            exhibitionId: state.pathParameters['id']!,
          ),
        ),
        GoRoute(
          path: '/exhibitor/exhibition/:id/layout',
          builder: (context, state) => StallLayoutScreen(
            exhibitionId: state.pathParameters['id']!,
          ),
        ),
        GoRoute(
          path: '/exhibitor/exhibition/:id/settings',
          builder: (context, state) => ExhibitionSettingsScreen(
            exhibitionId: state.pathParameters['id']!,
          ),
        ),
        GoRoute(
          path: '/exhibitor/create-exhibition',
          builder: (context, state) => const CreateExhibitionScreen(),
        ),
        GoRoute(
          path: '/exhibitor/edit-exhibition/:id',
          builder: (context, state) => EditExhibitionScreen(
            exhibitionId: state.pathParameters['id']!,
          ),
        ),
        GoRoute(
          path: '/exhibitor/exhibitions/:id/bookings',
          builder: (context, state) => StallBookingsScreen(
            exhibitionId: state.pathParameters['id']!,
          ),
        ),
        GoRoute(
          path: '/exhibitor/exhibitions/:exhibitionId/bookings/:bookingId',
          builder: (context, state) => BookingDetailsScreen(
            bookingId: state.pathParameters['bookingId']!,
          ),
        ),
        GoRoute(
          path: '/exhibitor/profile',
          builder: (context, state) => const ProfileScreen(),
        ),
        GoRoute(
          path: '/exhibitor/settings',
          builder: (context, state) => SettingsScreen(userType: 'exhibitor'),
        ),
        GoRoute(
          path: '/exhibitor/help',
          builder: (context, state) => HelpScreen(userType: 'exhibitor'),
        ),
      ],
    ),
  ],
  errorBuilder: (context, state) => Scaffold(
    body: Center(
      child: Text('Error: ${state.error}'),
    ),
  ),
); 