import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/exhibition_model.dart';
import '../../services/exhibition_service.dart';
import '../../widgets/exhibitor_bottom_nav.dart';

class EditExhibitionScreen extends StatefulWidget {
  final String exhibitionId;

  const EditExhibitionScreen({
    Key? key,
    required this.exhibitionId,
  }) : super(key: key);

  @override
  State<EditExhibitionScreen> createState() => _EditExhibitionScreenState();
}

class _EditExhibitionScreenState extends State<EditExhibitionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _exhibitionService = ExhibitionService();
  ExhibitionModel? _exhibition;
  bool _isLoading = true;
  bool _isSaving = false;

  // Form controllers
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _venueLocationController;
  late TextEditingController _pinCodeController;
  late TextEditingController _expectedFootfallController;
  late TextEditingController _stallCountController;
  late TextEditingController _shortDescriptionController;
  late TextEditingController _organizerNameController;
  late TextEditingController _organizerContactController;
  late TextEditingController _organizerAltContactController;
  late TextEditingController _organizerEmailController;

  DateTime? _startDate;
  DateTime? _endDate;
  String? _venueType;
  String? _timingType;
  String? _stallStructure;
  String? _bookingType;
  Set<String> _selectedCategories = {};
  Set<String> _selectedStallSizes = {};
  bool _requiresLookbook = false;
  String? _selectedVenueType;
  String? _selectedTimingType;
  String? _selectedStallStructure;
  String? _selectedBookingType;
  Map<String, double> _pricing = {'standard': 0.0};
  String? _organizerName;
  String? _organizerContact;
  String? _organizerAltContact;
  String? _organizerEmail;
  List<String> _galleryImages = [];

  final List<String> _venueTypes = ['Indoor', 'Outdoor', 'Hybrid'];
  final List<String> _timingTypes = ['Morning', 'Evening', 'Full Day'];
  final List<String> _stallStructures = ['Standard', 'Premium', 'Custom'];
  final List<String> _bookingTypes = ['First Come First Serve', 'Auction'];
  final List<String> _categories = [
    'Fashion',
    'Electronics',
    'Food & Beverage',
    'Home Decor',
    'Beauty',
    'Sports',
    'Automotive',
    'Other'
  ];
  final List<String> _stallSizes = [
    'Small (6x6)',
    'Medium (10x10)',
    'Large (15x15)',
    'Extra Large (20x20)'
  ];

  @override
  void initState() {
    super.initState();
    _initializeControllers();
    _loadExhibition();
  }

  void _initializeControllers() {
    _nameController = TextEditingController();
    _descriptionController = TextEditingController();
    _venueLocationController = TextEditingController();
    _pinCodeController = TextEditingController();
    _expectedFootfallController = TextEditingController();
    _stallCountController = TextEditingController();
    _shortDescriptionController = TextEditingController();
    _organizerNameController = TextEditingController();
    _organizerContactController = TextEditingController();
    _organizerAltContactController = TextEditingController();
    _organizerEmailController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _venueLocationController.dispose();
    _pinCodeController.dispose();
    _expectedFootfallController.dispose();
    _stallCountController.dispose();
    _shortDescriptionController.dispose();
    _organizerNameController.dispose();
    _organizerContactController.dispose();
    _organizerAltContactController.dispose();
    _organizerEmailController.dispose();
    super.dispose();
  }

  Future<void> _loadExhibition() async {
    try {
      final exhibition = await _exhibitionService.getExhibitionById(widget.exhibitionId);
      if (mounted) {
        setState(() {
          _exhibition = exhibition;
          _populateForm(exhibition);
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading exhibition: $e')),
        );
        setState(() => _isLoading = false);
      }
    }
  }

  void _populateForm(ExhibitionModel? exhibition) {
    if (exhibition == null) return;
    
    _nameController.text = exhibition.name;
    _descriptionController.text = exhibition.description;
    _venueLocationController.text = exhibition.venueLocation;
    _pinCodeController.text = exhibition.pinCode;
    _expectedFootfallController.text = exhibition.expectedFootfall.toString();
    _stallCountController.text = exhibition.stallCount.toString();
    _shortDescriptionController.text = exhibition.shortDescription;
    _organizerNameController.text = exhibition.organizerName;
    _organizerContactController.text = exhibition.organizerContact;
    _organizerAltContactController.text = exhibition.organizerAltContact;
    _organizerEmailController.text = exhibition.organizerEmail;

    _startDate = exhibition.startDate;
    _endDate = exhibition.endDate;
    _venueType = exhibition.venueType;
    _timingType = exhibition.timingType;
    _stallStructure = exhibition.stallStructure;
    _bookingType = exhibition.bookingType;
    _selectedCategories = Set.from(exhibition.invitedBrandCategories);
    _selectedStallSizes = Set.from(exhibition.stallSizes);
    _requiresLookbook = exhibition.requiresLookbook;
    _selectedVenueType = exhibition.venueType;
    _selectedTimingType = exhibition.timingType;
    _selectedStallStructure = exhibition.stallStructure;
    _selectedBookingType = exhibition.bookingType;
    _pricing = Map.from(exhibition.pricing);
    _organizerName = exhibition.organizerName;
    _organizerContact = exhibition.organizerContact;
    _organizerAltContact = exhibition.organizerAltContact;
    _organizerEmail = exhibition.organizerEmail;
    _galleryImages = List.from(exhibition.galleryImages);
  }

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isStartDate ? _startDate ?? DateTime.now() : _endDate ?? DateTime.now(),
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

  Future<void> _saveExhibition() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSaving = true);

    try {
      final updatedExhibition = ExhibitionModel(
        id: widget.exhibitionId,
        name: _nameController.text,
        description: _descriptionController.text,
        shortDescription: _shortDescriptionController.text,
        venueLocation: _venueLocationController.text,
        pinCode: _pinCodeController.text,
        expectedFootfall: int.parse(_expectedFootfallController.text),
        venueType: _selectedVenueType ?? 'Mall',
        timingType: _selectedTimingType ?? 'Day',
        invitedBrandCategories: _selectedCategories.toList(),
        requiresLookbook: _requiresLookbook,
        stallStructure: _selectedStallStructure ?? 'Standard',
        stallCount: int.parse(_stallCountController.text),
        stallSizes: _selectedStallSizes.toList(),
        bookingType: _selectedBookingType ?? 'Fixed',
        pricing: _pricing,
        organizerName: _organizerNameController.text,
        organizerContact: _organizerContactController.text,
        organizerAltContact: _organizerAltContactController.text,
        organizerEmail: _organizerEmailController.text,
        organizerId: widget.exhibitionId,
        startDate: _startDate!,
        endDate: _endDate!,
        status: 'Draft',
        galleryImages: _galleryImages,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await _exhibitionService.updateExhibition(updatedExhibition);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Exhibition updated successfully')),
        );
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error updating exhibition: $e')),
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
        title: const Text('Edit Exhibition'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _isSaving ? null : _saveExhibition,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _exhibition == null
              ? const Center(child: Text('Exhibition not found'))
              : _buildForm(),
      bottomNavigationBar: const ExhibitorBottomNav(),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBasicInfoSection(),
            const SizedBox(height: 24),
            _buildVenueInfoSection(),
            const SizedBox(height: 24),
            _buildStallInfoSection(),
            const SizedBox(height: 24),
            _buildCategoriesSection(),
            const SizedBox(height: 24),
            _buildStallSizesSection(),
          ],
        ),
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
            TextFormField(
              controller: _shortDescriptionController,
              decoration: const InputDecoration(
                labelText: 'Short Description',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter short description';
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
                    subtitle: Text(_startDate != null
                        ? '${_startDate!.day}/${_startDate!.month}/${_startDate!.year}'
                        : 'Select date'),
                    onTap: () => _selectDate(context, true),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: const Text('End Date'),
                    subtitle: Text(_endDate != null
                        ? '${_endDate!.day}/${_endDate!.month}/${_endDate!.year}'
                        : 'Select date'),
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

  Widget _buildVenueInfoSection() {
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
              value: _venueType,
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
                setState(() => _venueType = value);
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select venue type';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _venueLocationController,
              decoration: const InputDecoration(
                labelText: 'Location',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter location';
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
              value: _timingType,
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
                setState(() => _timingType = value);
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select timing type';
                }
                return null;
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

  Widget _buildStallInfoSection() {
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
              value: _stallStructure,
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
                setState(() => _stallStructure = value);
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select stall structure';
                }
                return null;
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
              value: _bookingType,
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
                setState(() => _bookingType = value);
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select booking type';
                }
                return null;
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
              children: _categories.map((category) {
                return FilterChip(
                  label: Text(category),
                  selected: _selectedCategories.contains(category),
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
              children: _stallSizes.map((size) {
                return FilterChip(
                  label: Text(size),
                  selected: _selectedStallSizes.contains(size),
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