import 'package:flutter/material.dart';
import '../../config/theme.dart';
import 'package:go_router/go_router.dart';

class BrandsScreen extends StatelessWidget {
  const BrandsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: 10, // TODO: Replace with actual brand count
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.only(bottom: 16.0),
          child: ListTile(
            leading: const CircleAvatar(
              child: Icon(Icons.business),
            ),
            title: Text('Brand ${index + 1}'),
            subtitle: Text('Category ${index + 1}'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // TODO: Navigate to brand details
              context.go('/exhibitor/brands/${index + 1}');
            },
          ),
        );
      },
    );
  }
} 