import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/register_screen.dart';
import 'screens/splash_screen.dart';
import 'screens/brand/dashboard_screen.dart';
import 'screens/brand/brand_profile_screen.dart';
import 'screens/brand/lookbook_screen.dart';
import 'screens/brand/exhibition_details_screen.dart' as brand_exhibition;
import 'screens/brand/book_stall_screen.dart';
import 'screens/brand/my_bookings_screen.dart';
import 'screens/brand/booking_details_screen.dart' as brand_booking;
import 'screens/brand/my_products_screen.dart';
import 'screens/brand/browse_exhibitions_screen.dart';
import 'screens/exhibitor/dashboard_screen.dart';
import 'screens/exhibitor/settings_screen.dart';
import 'screens/exhibitor/create_exhibition_screen.dart';
import 'screens/exhibitor/my_exhibitions_screen.dart';
import 'screens/exhibitor/stall_management_screen.dart';
import 'screens/exhibitor/exhibition_details_screen.dart' as exhibitor_exhibition;
import 'screens/exhibitor/stall_details_screen.dart';
import 'screens/exhibitor/exhibition_settings_screen.dart';
import 'screens/exhibitor/bookings_screen.dart';
import 'screens/exhibitor/brands_screen.dart';
import 'screens/exhibitor/stall_bookings_screen.dart';
import 'screens/exhibitor/stall_layout_screen.dart';
import 'screens/exhibitor/exhibition_form_screen.dart';
import 'screens/exhibitor/booking_details_screen.dart' as exhibitor_booking;
import 'screens/exhibitor/analytics_screen.dart';
import 'screens/shopper/dashboard_screen.dart';
import 'widgets/exhibitor_layout.dart';
import 'models/exhibition.dart';
import 'screens/exhibitor/layout_creation_screen.dart';
import 'screens/exhibitor/exhibition_media_screen.dart';

final router = GoRouter(
  initialLocation: '/splash',
  routes: [
    // Splash Screen
    GoRoute(
      path: '/splash',
      builder: (context, state) => const SplashScreen(),
    ),
    // Auth Routes
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterScreen(),
    ),
    
    // Brand Routes
    GoRoute(
      path: '/brand/dashboard',
      builder: (context, state) => const DashboardScreen(),
    ),
    GoRoute(
      path: '/brand/profile',
      builder: (context, state) => const BrandProfileScreen(),
    ),
    GoRoute(
      path: '/brand/lookbook',
      builder: (context, state) => const LookbookScreen(),
    ),
    GoRoute(
      path: '/brand/exhibitions/:id',
      builder: (context, state) => brand_exhibition.ExhibitionDetailsScreen(
        exhibitionId: state.pathParameters['id']!,
      ),
    ),
    GoRoute(
      path: '/brand/exhibitions/:id/book',
      builder: (context, state) => BookStallScreen(
        exhibitionId: state.pathParameters['id']!,
      ),
    ),
    GoRoute(
      path: '/brand/bookings',
      builder: (context, state) => const BrandBookingsScreen(),
    ),
    GoRoute(
      path: '/brand/bookings/:id',
      builder: (context, state) => brand_booking.BookingDetailsScreen(
        bookingId: state.pathParameters['id']!,
      ),
    ),
    GoRoute(
      path: '/brand/products',
      builder: (context, state) => const MyProductsScreen(),
    ),
    GoRoute(
      path: '/brand/exhibitions',
      builder: (context, state) => const BrowseExhibitionsScreen(),
    ),

    // Exhibitor Routes
    GoRoute(
      path: '/exhibitor',
      builder: (context, state) => const ExhibitorLayout(
        currentIndex: 0,
        child: DashboardScreen(),
      ),
      routes: [
        GoRoute(
          path: 'dashboard',
          builder: (context, state) => const ExhibitorLayout(
            currentIndex: 0,
            child: DashboardScreen(),
          ),
        ),
        GoRoute(
          path: 'exhibitions',
          builder: (context, state) => const ExhibitorLayout(
            currentIndex: 1,
            child: MyExhibitionsScreen(),
          ),
        ),
        GoRoute(
          path: 'exhibitions/:id',
          builder: (context, state) => ExhibitorLayout(
            currentIndex: 1,
            child: exhibitor_exhibition.ExhibitionDetailsScreen(
              exhibition: Exhibition(
                id: state.pathParameters['id']!,
                name: 'Tech Expo 2024',
                description: 'Annual technology exhibition showcasing the latest innovations',
                venue: 'Convention Center, New York',
                startDate: DateTime.now(),
                endDate: DateTime.now().add(const Duration(days: 3)),
                status: 'Active',
                imageUrl: 'https://picsum.photos/800/400',
                totalStalls: 50,
                availableStalls: 12,
                pricePerStall: 1000.0,
              ),
            ),
          ),
          routes: [
            GoRoute(
              path: 'form',
              builder: (context, state) => ExhibitorLayout(
                currentIndex: 1,
                child: ExhibitionFormScreen(
                  exhibitionId: state.pathParameters['id']!,
                ),
              ),
            ),
            GoRoute(
              path: 'settings',
              builder: (context, state) => ExhibitorLayout(
                currentIndex: 1,
                child: ExhibitionSettingsScreen(
                  exhibitionId: state.pathParameters['id']!,
                ),
              ),
            ),
            GoRoute(
              path: 'layout',
              builder: (context, state) => ExhibitorLayout(
                currentIndex: 1,
                child: LayoutCreationScreen(
                  exhibitionId: state.pathParameters['id']!,
                ),
              ),
            ),
            GoRoute(
              path: 'media',
              builder: (context, state) => ExhibitorLayout(
                currentIndex: 1,
                child: ExhibitionMediaScreen(
                  exhibitionId: state.pathParameters['id']!,
                ),
              ),
            ),
            GoRoute(
              path: 'stalls',
              builder: (context, state) => ExhibitorLayout(
                currentIndex: 1,
                child: StallManagementScreen(
                  exhibitionId: state.pathParameters['id']!,
                ),
              ),
            ),
          ],
        ),
        GoRoute(
          path: 'bookings',
          builder: (context, state) => const ExhibitorLayout(
            currentIndex: 2,
            child: BookingsScreen(),
          ),
          routes: [
            GoRoute(
              path: ':id',
              builder: (context, state) => ExhibitorLayout(
                currentIndex: 2,
                child: exhibitor_booking.BookingDetailsScreen(
                  bookingId: state.pathParameters['id']!,
                ),
              ),
            ),
          ],
        ),
        GoRoute(
          path: 'settings',
          builder: (context, state) => const ExhibitorLayout(
            currentIndex: 3,
            child: SettingsScreen(),
          ),
        ),
      ],
    ),
    GoRoute(
      path: '/exhibitor/stalls/:id',
      builder: (context, state) => StallDetailsScreen(
        exhibitionId: state.pathParameters['id']!,
      ),
    ),
    GoRoute(
      path: '/exhibitor/exhibitions/:id/layout',
      builder: (context, state) => StallLayoutScreen(
        exhibitionId: state.pathParameters['id']!,
      ),
    ),
    GoRoute(
      path: '/exhibitor/exhibitions/:id/form',
      builder: (context, state) => ExhibitionFormScreen(
        exhibitionId: state.pathParameters['id']!,
      ),
    ),
    GoRoute(
      path: '/exhibitor/analytics',
      builder: (context, state) => const AnalyticsScreen(
        exhibitionId: 'default',
      ),
    ),

    // Shopper Routes
    GoRoute(
      path: '/shopper/dashboard',
      builder: (context, state) => const ShopperDashboardScreen(),
    ),
    GoRoute(
      path: '/shopper',
      redirect: (context, state) => '/shopper/dashboard',
    ),
  ],
  errorBuilder: (context, state) => Scaffold(
    body: Center(
      child: Text('Error: ${state.error}'),
    ),
  ),
); 