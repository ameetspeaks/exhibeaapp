import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late PageController _pageController;
  int _currentPage = 0;
  late AnimationController _animationController;

  final List<SplashPage> _splashPages = [
    SplashPage(
      title: 'Welcome to Exhibea',
      description: 'Your one-stop platform for managing exhibitions and events',
      image: 'assets/images/splash/splash1.png',
    ),
    SplashPage(
      title: 'Manage Exhibitions',
      description: 'Create, manage, and track your exhibitions with ease',
      image: 'assets/images/splash/splash2.png',
    ),
    SplashPage(
      title: 'Connect with Brands',
      description: 'Connect with brands and manage stall bookings efficiently',
      image: 'assets/images/splash/splash3.png',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  void _navigateToLogin() {
    context.go('/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            itemCount: _splashPages.length,
            itemBuilder: (context, index) {
              return _buildSplashPage(_splashPages[index]);
            },
          ),
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    _splashPages.length,
                    (index) => _buildDot(index),
                  ),
                ),
                const SizedBox(height: 20),
                if (_currentPage == _splashPages.length - 1)
                  FilledButton(
                    onPressed: _navigateToLogin,
                    style: FilledButton.styleFrom(
                      minimumSize: const Size(200, 50),
                    ),
                    child: const Text('Get Started'),
                  )
                else
                  TextButton(
                    onPressed: _navigateToLogin,
                    child: const Text('Skip'),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSplashPage(SplashPage page) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              page.image,
              height: 300,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                print('Error loading image: ${page.image}');
                print('Error: $error');
                return Container(
                  height: 300,
                  width: double.infinity,
                  color: Colors.grey[200],
                  child: const Icon(
                    Icons.error_outline,
                    size: 100,
                    color: Colors.red,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 40),
          Text(
            page.title,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            page.description,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.grey[600],
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildDot(int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: 8,
      width: _currentPage == index ? 24 : 8,
      decoration: BoxDecoration(
        color: _currentPage == index
            ? Theme.of(context).colorScheme.primary
            : Colors.grey[300],
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}

class SplashPage {
  final String title;
  final String description;
  final String image;

  SplashPage({
    required this.title,
    required this.description,
    required this.image,
  });
} 