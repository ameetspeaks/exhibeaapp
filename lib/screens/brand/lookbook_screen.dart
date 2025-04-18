import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

class LookbookScreen extends StatelessWidget {
  const LookbookScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lookbook'),
      ),
      body: const Center(
        child: Text('Lookbook Screen'),
      ),
    );
  }
} 