import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import '../../models/exhibition_model.dart';
import '../../services/exhibition_service.dart';
import '../../widgets/exhibitor_bottom_nav.dart';

class CreateExhibitionScreen extends StatefulWidget {
  const CreateExhibitionScreen({Key? key}) : super(key: key);

  @override
  State<CreateExhibitionScreen> createState() => _CreateExhibitionScreenState();
}

class _CreateExhibitionScreenState extends State<CreateExhibitionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _exhibitionService = ExhibitionService();
  bool _isSaving = false;

  // Form controllers
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _venueLocationController = TextEditingController();
  final _pinCodeController = TextEditingController();
  final _expectedFootfallController = TextEditingController();
  final _stallCountController = TextEditingController();
  DateTime? _startDate;
  DateTime? _endDate;
  String _selectedTimingType = 'Day';
  String _selectedVenueType = 'Indoor';
  String _selectedBookingType = 'First Come First Serve';
  String _selectedStallStructure = 'Standard';
  List<String> _selectedCategories = [];
  List<String> _selectedStallSizes = [];

  final List<String> _timingTypes = ['Day', 'Night', '24 Hours'];
  final List<String> _venueTypes = ['Indoor', 'Outdoor', 'Both'];
  final List<String> _bookingTypes = ['First Come First Serve', 'Auction', 'Fixed Price'];
  final List<String> _stallStructures = ['Standard', 'Premium', 'Custom'];
  final List<String> _brandCategories = [
    'Fashion',
    'Electronics',
    'Food & Beverages',
    'Home & Living',
    'Beauty & Personal Care',
    'Sports & Fitness',
    'Automotive',
    'Others'
  ];
  final List<String> _availableStallSizes = [
    '6x6',
    '6x8',
    '8x8',
    '8x10',
    '10x10',
    '10x12',
    '12x12',
    'Custom'
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _venueLocationController.dispose();
    _pinCodeController.dispose();
    _expectedFootfallController.dispose();
    _stallCountController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      setState(() {
        if (isStartDate) {
          _startDate = picked;
        } else {
          _endDate = picked;
        }
      });
    }
  }

  Future<void> _createExhibition() async {
    if (!_formKey.currentState!.validate()) return;
    if (_startDate == null || _endDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select start and end dates')),
      );
      return;
    }

    setState(() => _isSaving = true);

    try {
      final exhibition = ExhibitionModel(
        id: const Uuid().v4(),
        name: _nameController.text,
        description: _descriptionController.text,
        shortDescription: _descriptionController.text.split('\n').first,
        venueLocation: _venueLocationController.text,
        pinCode: _pinCodeController.text,
        expectedFootfall: int.parse(_expectedFootfallController.text),
        venueType: _selectedVenueType,
        timingType: _selectedTimingType,
        invitedBrandCategories: _selectedCategories,
        requiresLookbook: false,
        stallStructure: _selectedStallStructure,
        stallCount: int.parse(_stallCountController.text),
        stallSizes: _selectedStallSizes,
        bookingType: _selectedBookingType,
        pricing: {'standard': 0.0},
        organizerName: 'Current User',
        organizerContact: '1234567890',
        organizerAltContact: '0987654321',
        organizerEmail: 'user@example.com',
        organizerId: 'current_user_id',
        startDate: _startDate!,
        endDate: _endDate!,
        status: 'pending',
        galleryImages: [],
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await _exhibitionService.createExhibition(exhibition);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Exhibition created successfully')),
        );
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error creating exhibition: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Exhibition'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _isSaving ? null : _createExhibition,
          ),
        ],
      ),
      body: _buildForm(),
      bottomNavigationBar: const ExhibitorBottomNav(),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildBasicInfoSection(),
          const SizedBox(height: 24),
          _buildVenueSection(),
          const SizedBox(height: 24),
          _buildStallSection(),
          const SizedBox(height: 24),
          _buildCategoriesSection(),
          const SizedBox(height: 24),
          _buildStallSizesSection(),
        ],
      ),
    );
  }

  Widget _buildBasicInfoSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Basic Information',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Exhibition Name',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter exhibition name';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter description';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ListTile(
                    title: const Text('Start Date'),
                    subtitle: Text(_startDate == null
                        ? 'Select date'
                        : '${_startDate!.day}/${_startDate!.month}/${_startDate!.year}'),
                    onTap: () => _selectDate(context, true),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: const Text('End Date'),
                    subtitle: Text(_endDate == null
                        ? 'Select date'
                        : '${_endDate!.day}/${_endDate!.month}/${_endDate!.year}'),
                    onTap: () => _selectDate(context, false),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVenueSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Venue Information',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _selectedVenueType,
              decoration: const InputDecoration(
                labelText: 'Venue Type',
                border: OutlineInputBorder(),
              ),
              items: _venueTypes.map((type) {
                return DropdownMenuItem(
                  value: type,
                  child: Text(type),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() => _selectedVenueType = value);
                }
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _venueLocationController,
              decoration: const InputDecoration(
                labelText: 'Venue Location',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter venue location';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _pinCodeController,
              decoration: const InputDecoration(
                labelText: 'Pin Code',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter pin code';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _selectedTimingType,
              decoration: const InputDecoration(
                labelText: 'Timing Type',
                border: OutlineInputBorder(),
              ),
              items: _timingTypes.map((type) {
                return DropdownMenuItem(
                  value: type,
                  child: Text(type),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() => _selectedTimingType = value);
                }
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _expectedFootfallController,
              decoration: const InputDecoration(
                labelText: 'Expected Footfall',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter expected footfall';
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStallSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Stall Information',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _selectedStallStructure,
              decoration: const InputDecoration(
                labelText: 'Stall Structure',
                border: OutlineInputBorder(),
              ),
              items: _stallStructures.map((structure) {
                return DropdownMenuItem(
                  value: structure,
                  child: Text(structure),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() => _selectedStallStructure = value);
                }
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _stallCountController,
              decoration: const InputDecoration(
                labelText: 'Total Stalls',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter total stalls';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _selectedBookingType,
              decoration: const InputDecoration(
                labelText: 'Booking Type',
                border: OutlineInputBorder(),
              ),
              items: _bookingTypes.map((type) {
                return DropdownMenuItem(
                  value: type,
                  child: Text(type),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() => _selectedBookingType = value);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoriesSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Invited Categories',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _brandCategories.map((category) {
                final isSelected = _selectedCategories.contains(category);
                return FilterChip(
                  label: Text(category),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      if (selected) {
                        _selectedCategories.add(category);
                      } else {
                        _selectedCategories.remove(category);
                      }
                    });
                  },
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStallSizesSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Available Stall Sizes',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _availableStallSizes.map((size) {
                final isSelected = _selectedStallSizes.contains(size);
                return FilterChip(
                  label: Text(size),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      if (selected) {
                        _selectedStallSizes.add(size);
                      } else {
                        _selectedStallSizes.remove(size);
                      }
                    });
                  },
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
} 