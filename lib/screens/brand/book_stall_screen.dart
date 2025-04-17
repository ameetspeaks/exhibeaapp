import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BookStallScreen extends StatefulWidget {
  final String exhibitionId;

  const BookStallScreen({
    super.key,
    required this.exhibitionId,
  });

  @override
  State<BookStallScreen> createState() => _BookStallScreenState();
}

class _BookStallScreenState extends State<BookStallScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String _selectedStall = '';
  String _contactPerson = '';
  String _contactEmail = '';
  String _contactPhone = '';
  String _additionalNotes = '';

  List<Map<String, dynamic>> _availableStalls = [
    {'id': 'A-101', 'price': '₹50,000', 'description': 'Premium stall at main entrance'},
    {'id': 'A-102', 'price': '₹45,000', 'description': 'Standard stall at main entrance'},
    {'id': 'B-201', 'price': '₹40,000', 'description': 'Standard stall at side entrance'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book a Stall'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Available Stalls',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ..._availableStalls.map((stall) => _buildStallCard(stall)),
                    const SizedBox(height: 24),
                    const Text(
                      'Contact Information',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Contact Person',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter contact person name';
                        }
                        return null;
                      },
                      onSaved: (value) => _contactPerson = value!,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter email';
                        }
                        if (!value.contains('@')) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                      onSaved: (value) => _contactEmail = value!,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Phone Number',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter phone number';
                        }
                        return null;
                      },
                      onSaved: (value) => _contactPhone = value!,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Additional Notes',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 3,
                      onSaved: (value) => _additionalNotes = value ?? '',
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _submitBooking,
                        child: const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text('Submit Booking'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildStallCard(Map<String, dynamic> stall) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: RadioListTile<String>(
        title: Text(
          'Stall ${stall['id']}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Price: ${stall['price']}'),
            Text(stall['description']),
          ],
        ),
        value: stall['id'],
        groupValue: _selectedStall,
        onChanged: (value) {
          setState(() {
            _selectedStall = value!;
          });
        },
      ),
    );
  }

  Future<void> _submitBooking() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_selectedStall.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a stall')),
      );
      return;
    }

    _formKey.currentState!.save();
    setState(() => _isLoading = true);

    try {
      // TODO: Implement booking submission logic
      await Future.delayed(const Duration(seconds: 2)); // Simulated API call
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Booking submitted successfully')),
        );
        context.go('/brand/my-bookings');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error submitting booking: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }
} 