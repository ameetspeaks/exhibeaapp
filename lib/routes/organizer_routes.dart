import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../screens/exhibitor/dashboard_screen.dart';
import '../screens/exhibitor/my_exhibitions_screen.dart';
import '../screens/exhibitor/exhibition_form_screen.dart';
import '../screens/exhibitor/exhibition_details_screen.dart';
import '../screens/exhibitor/bookings_screen.dart';
import '../screens/profile_screen.dart';
import '../widgets/exhibitor_layout.dart';

final exhibitorRoutes = [
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
        path: '/exhibitor/exhibitions',
        builder: (context, state) => const MyExhibitionsScreen(),
      ),
      GoRoute(
        path: '/exhibitor/exhibitions/new',
        builder: (context, state) => const ExhibitionFormScreen(),
      ),
      GoRoute(
        path: '/exhibitor/exhibitions/:id',
        builder: (context, state) => ExhibitionDetailsScreen(
          exhibitionId: state.pathParameters['id']!,
        ),
      ),
      GoRoute(
        path: '/exhibitor/exhibitions/:id/edit',
        builder: (context, state) => ExhibitionFormScreen(
          exhibitionId: state.pathParameters['id']!,
        ),
      ),
      GoRoute(
        path: '/exhibitor/exhibitions/:id/bookings',
        builder: (context, state) => BookingsScreen(
          exhibitionId: state.pathParameters['id']!,
        ),
      ),
      GoRoute(
        path: '/exhibitor/profile',
        builder: (context, state) => const ProfileScreen(),
      ),
    ],
  ),
]; 