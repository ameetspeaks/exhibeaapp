import 'package:flutter/material.dart';

class SavedEventsScreen extends StatefulWidget {
  const SavedEventsScreen({super.key});

  @override
  State<SavedEventsScreen> createState() => _SavedEventsScreenState();
}

class _SavedEventsScreenState extends State<SavedEventsScreen> {
  bool _isLoading = true;
  final List<Map<String, dynamic>> _savedEvents = [];

  @override
  void initState() {
    super.initState();
    _loadSavedEvents();
  }

  Future<void> _loadSavedEvents() async {
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));
      
      setState(() {
        _savedEvents.addAll([
          {
            'id': '1',
            'title': 'Tech Expo 2024',
            'date': '2024-07-15',
            'location': 'Convention Center',
            'imageUrl': 'https://example.com/tech-expo.jpg',
          },
          {
            'id': '2',
            'title': 'Fashion Week',
            'date': '2024-08-20',
            'location': 'Fashion District',
            'imageUrl': 'https://example.com/fashion-week.jpg',
          },
        ]);
        _isLoading = false;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load saved events: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Events'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _savedEvents.isEmpty
              ? const Center(
                  child: Text('No saved events yet'),
                )
              : ListView.builder(
                  itemCount: _savedEvents.length,
                  itemBuilder: (context, index) {
                    final event = _savedEvents[index];
                    return Card(
                      margin: const EdgeInsets.all(8.0),
                      child: ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            event['imageUrl'],
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(Icons.error);
                            },
                          ),
                        ),
                        title: Text(event['title']),
                        subtitle: Text(
                          '${event['date']} • ${event['location']}',
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.favorite, color: Colors.red),
                          onPressed: () {
                            // TODO: Implement unsave functionality
                          },
                        ),
                      ),
                    );
                  },
                ),
    );
  }
} 