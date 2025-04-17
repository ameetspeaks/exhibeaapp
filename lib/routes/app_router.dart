import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../screens/auth/auth_screen.dart';
import '../screens/role_selection_screen.dart';
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
import '../widgets/shopper_layout.dart';
import '../widgets/exhibitor_layout.dart';
import '../screens/auth/login_screen.dart';
import '../screens/home_screen.dart';
import '../screens/shopper/brand_screen.dart';
import '../screens/shopper/exhibitor_screen.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const RoleSelectionScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/login/brand',
      builder: (context, state) => const LoginScreen(role: 'brand'),
    ),
    GoRoute(
      path: '/login/exhibitor',
      builder: (context, state) => const LoginScreen(role: 'exhibitor'),
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
      ],
    ),
    ShellRoute(
      builder: (context, state, child) => ExhibitorLayout(child: child),
      routes: [
        GoRoute(
          path: '/exhibitor',
          redirect: (context, state) => '/exhibitor/dashboard',
        ),
        GoRoute(
          path: '/exhibitor/dashboard',
          builder: (context, state) => const DashboardScreen(),
        ),
        GoRoute(
          path: '/exhibitor/my-exhibitions',
          builder: (context, state) => const MyExhibitionsScreen(),
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
      ],
    ),
  ],
  errorBuilder: (context, state) => Scaffold(
    body: Center(
      child: Text('Error: ${state.error}'),
    ),
  ),
); 