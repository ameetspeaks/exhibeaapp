import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/register_screen.dart';
import '../screens/home_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/organizer/dashboard_screen.dart';
import '../screens/organizer/my_exhibitions_screen.dart';
import '../screens/organizer/exhibition_details_screen.dart';
import '../screens/organizer/edit_exhibition_screen.dart';
import '../screens/organizer/create_exhibition_screen.dart';
import '../screens/brand/dashboard_screen.dart';
import '../screens/shopper/dashboard_screen.dart';

final router = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => const ProfileScreen(),
    ),
    // Organizer routes
    GoRoute(
      path: '/organizer/dashboard',
      builder: (context, state) => const OrganizerDashboardScreen(),
    ),
    GoRoute(
      path: '/organizer/exhibitions',
      builder: (context, state) => const MyExhibitionsScreen(),
    ),
    GoRoute(
      path: '/organizer/exhibitions/create',
      builder: (context, state) => const CreateExhibitionScreen(),
    ),
    GoRoute(
      path: '/organizer/exhibitions/:id',
      builder: (context, state) => ExhibitionDetailsScreen(
        exhibitionId: state.pathParameters['id']!,
      ),
    ),
    GoRoute(
      path: '/organizer/exhibitions/:id/edit',
      builder: (context, state) => EditExhibitionScreen(
        exhibitionId: state.pathParameters['id']!,
      ),
    ),
    // Brand routes
    GoRoute(
      path: '/brand/dashboard',
      builder: (context, state) => const BrandDashboardScreen(),
    ),
    // Shopper routes
    GoRoute(
      path: '/shopper/dashboard',
      builder: (context, state) => const ShopperDashboardScreen(),
    ),
  ],
); 