import 'package:flutter/material.dart';

class BrandScreen extends StatelessWidget {
  final String brandId;

  const BrandScreen({
    Key? key,
    required this.brandId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Brand Details'),
      ),
      body: Center(
        child: Text('Brand ID: $brandId'),
      ),
    );
  }
} 