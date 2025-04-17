import 'package:flutter/material.dart';

class ExhibitorScreen extends StatelessWidget {
  final String exhibitorId;

  const ExhibitorScreen({
    Key? key,
    required this.exhibitorId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exhibitor Details'),
      ),
      body: Center(
        child: Text('Exhibitor ID: $exhibitorId'),
      ),
    );
  }
} 