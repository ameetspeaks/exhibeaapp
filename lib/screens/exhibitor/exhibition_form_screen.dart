import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import '../../models/exhibition_model.dart';
import '../../services/exhibition_service.dart';
import '../../widgets/exhibitor_bottom_nav.dart';

class ExhibitionFormScreen extends StatefulWidget {
  final String? exhibitionId;

  const ExhibitionFormScreen({super.key, this.exhibitionId});

  @override
  State<ExhibitionFormScreen> createState() => _ExhibitionFormScreenState();
}

class _ExhibitionFormScreenState extends State<ExhibitionFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _exhibitionService = ExhibitionService();
  int _currentStep = 0;
  bool _isLoading = false;
  bool _isEditing = false;
  ExhibitionModel? _exhibition;

  // Form controllers
  final _nameController = TextEditingController();
  final _shortDescriptionController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _venueLocationController = TextEditingController();
  final _pinCodeController = TextEditingController();
  final _expectedFootfallController = TextEditingController();
  final _organizerNameController = TextEditingController();
  final _organizerContactController = TextEditingController();
  final _organizerAltContactController = TextEditingController();
  final _organizerEmailController = TextEditingController();

  // Form values
  String _venueType = 'indoor';
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now().add(const Duration(days: 1));
  String _timingType = 'fixed';
  List<String> _invitedBrandCategories = [];
  bool _requiresLookbook = false;
  String _stallStructure = 'standard';
  int _stallCount = 0;
  List<String> _stallSizes = [];
  String _bookingType = 'first-come-first-serve';
  Map<String, double> _pricing = {
    'Small': 1000.0,
    'Medium': 2000.0,
    'Large': 3000.0,
  };

  @override
  void initState() {
    super.initState();
    _isEditing = widget.exhibitionId != null;
    if (_isEditing) {
      _loadExhibition();
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _shortDescriptionController.dispose();
    _descriptionController.dispose();
    _venueLocationController.dispose();
    _pinCodeController.dispose();
    _expectedFootfallController.dispose();
    _organizerNameController.dispose();
    _organizerContactController.dispose();
    _organizerAltContactController.dispose();
    _organizerEmailController.dispose();
    super.dispose();
  }

  Future<void> _loadExhibition() async {
    setState(() => _isLoading = true);
    
    try {
      final exhibition = await _exhibitionService.getExhibitionById(widget.exhibitionId!);
      if (mounted) {
        setState(() {
          _exhibition = exhibition;
          if (exhibition != null) {
            _initializeFormWithExhibition(exhibition);
          }
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

  void _initializeFormWithExhibition(ExhibitionModel exhibition) {
    _nameController.text = exhibition.name;
    _shortDescriptionController.text = exhibition.shortDescription;
    _descriptionController.text = exhibition.description;
    _venueLocationController.text = exhibition.venueLocation;
    _pinCodeController.text = exhibition.pinCode;
    _expectedFootfallController.text = exhibition.expectedFootfall.toString();
    _venueType = exhibition.venueType;
    _startDate = exhibition.startDate;
    _endDate = exhibition.endDate;
    _timingType = exhibition.timingType;
    _invitedBrandCategories = List.from(exhibition.invitedBrandCategories);
    _requiresLookbook = exhibition.requiresLookbook;
    _stallStructure = exhibition.stallStructure;
    _stallCount = exhibition.stallCount;
    _stallSizes = List.from(exhibition.stallSizes);
    _bookingType = exhibition.bookingType;
    _pricing = Map<String, double>.from(exhibition.pricing);
    _organizerNameController.text = exhibition.organizerName;
    _organizerContactController.text = exhibition.organizerContact;
    _organizerAltContactController.text = exhibition.organizerAltContact;
    _organizerEmailController.text = exhibition.organizerEmail;
  }

  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      // Safely parse numeric values
      final expectedFootfall = int.tryParse(_expectedFootfallController.text) ?? 0;
      final stallCount = _stallCount;

      // Ensure dates are valid
      if (_endDate.isBefore(_startDate)) {
        throw Exception('End date must be after start date');
      }

      // Create pricing map with safe defaults
      final pricing = <String, double>{
        'Small': _pricing['Small'] ?? 0.0,
        'Medium': _pricing['Medium'] ?? 0.0,
        'Large': _pricing['Large'] ?? 0.0,
        'XL': _pricing['XL'] ?? 0.0,
      };

      final exhibition = ExhibitionModel(
        id: widget.exhibitionId ?? const Uuid().v4(),
        name: _nameController.text.trim(),
        shortDescription: _shortDescriptionController.text.trim(),
        description: _descriptionController.text.trim(),
        venueType: _venueType,
        venueLocation: _venueLocationController.text.trim(),
        pinCode: _pinCodeController.text.trim(),
        startDate: _startDate,
        endDate: _endDate,
        timingType: _timingType,
        expectedFootfall: expectedFootfall,
        stallStructure: _stallStructure,
        stallCount: stallCount,
        bookingType: _bookingType,
        invitedBrandCategories: _invitedBrandCategories,
        stallSizes: _stallSizes,
        status: _exhibition?.status ?? 'pending',
        organizerId: _exhibition?.organizerId ?? 'current_user_id',
        organizerName: _organizerNameController.text.trim(),
        organizerContact: _organizerContactController.text.trim(),
        organizerAltContact: _organizerAltContactController.text.trim(),
        organizerEmail: _organizerEmailController.text.trim(),
        createdAt: _exhibition?.createdAt ?? DateTime.now(),
        updatedAt: DateTime.now(),
        galleryImages: _exhibition?.galleryImages ?? [],
        requiresLookbook: _requiresLookbook,
        pricing: pricing,
      );

      if (widget.exhibitionId == null) {
        await _exhibitionService.createExhibition(exhibition);
      } else {
        await _exhibitionService.updateExhibition(exhibition);
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_isEditing ? 'Exhibition updated successfully' : 'Exhibition created successfully'),
          ),
        );
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Edit Exhibition' : 'Create Exhibition'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Form(
              key: _formKey,
              child: Stepper(
                currentStep: _currentStep,
                onStepContinue: () {
                  if (_currentStep < 2) {
                    setState(() => _currentStep++);
                  } else {
                    _handleSubmit();
                  }
                },
                onStepCancel: () {
                  if (_currentStep > 0) {
                    setState(() => _currentStep--);
                  } else {
                    context.pop();
                  }
                },
                steps: [
                  Step(
                    title: const Text('Basic Details'),
                    content: Column(
                      children: [
                        TextFormField(
                          controller: _nameController,
                          decoration: const InputDecoration(labelText: 'Exhibition Name'),
                          validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
                        ),
                        TextFormField(
                          controller: _shortDescriptionController,
                          decoration: const InputDecoration(labelText: 'Short Description'),
                          validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
                        ),
                        TextFormField(
                          controller: _descriptionController,
                          decoration: const InputDecoration(labelText: 'Description'),
                          maxLines: 3,
                          validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
                        ),
                        DropdownButtonFormField<String>(
                          value: _venueType,
                          decoration: const InputDecoration(labelText: 'Venue Type'),
                          items: ['indoor', 'outdoor', 'hybrid']
                              .map((type) => DropdownMenuItem(
                                    value: type,
                                    child: Text(type.capitalize()),
                                  ))
                              .toList(),
                          onChanged: (value) => setState(() => _venueType = value!),
                        ),
                        TextFormField(
                          controller: _venueLocationController,
                          decoration: const InputDecoration(labelText: 'Venue Location'),
                          validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
                        ),
                        TextFormField(
                          controller: _pinCodeController,
                          decoration: const InputDecoration(labelText: 'Pin Code'),
                          keyboardType: TextInputType.number,
                          validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
                        ),
                        TextFormField(
                          controller: _expectedFootfallController,
                          decoration: const InputDecoration(labelText: 'Expected Footfall'),
                          keyboardType: TextInputType.number,
                          validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
                        ),
                        ListTile(
                          title: const Text('Start Date'),
                          subtitle: Text(_startDate.toString().split(' ')[0]),
                          onTap: () async {
                            final date = await showDatePicker(
                              context: context,
                              initialDate: _startDate,
                              firstDate: DateTime.now(),
                              lastDate: DateTime.now().add(const Duration(days: 365)),
                            );
                            if (date != null) {
                              setState(() => _startDate = date);
                            }
                          },
                        ),
                        ListTile(
                          title: const Text('End Date'),
                          subtitle: Text(_endDate.toString().split(' ')[0]),
                          onTap: () async {
                            final date = await showDatePicker(
                              context: context,
                              initialDate: _endDate,
                              firstDate: _startDate,
                              lastDate: DateTime.now().add(const Duration(days: 365)),
                            );
                            if (date != null) {
                              setState(() => _endDate = date);
                            }
                          },
                        ),
                      ],
                    ),
                    isActive: _currentStep >= 0,
                  ),
                  Step(
                    title: const Text('Stall Details'),
                    content: Column(
                      children: [
                        DropdownButtonFormField<String>(
                          value: _timingType,
                          decoration: const InputDecoration(labelText: 'Timing Type'),
                          items: ['fixed', 'flexible']
                              .map((type) => DropdownMenuItem(
                                    value: type,
                                    child: Text(type.capitalize()),
                                  ))
                              .toList(),
                          onChanged: (value) => setState(() => _timingType = value!),
                        ),
                        Wrap(
                          spacing: 8.0,
                          children: [
                            'Fashion',
                            'Electronics',
                            'Food',
                            'Home Decor',
                            'Beauty',
                            'Sports',
                          ].map((category) {
                            final isSelected = _invitedBrandCategories.contains(category);
                            return FilterChip(
                              label: Text(category),
                              selected: isSelected,
                              onSelected: (selected) {
                                setState(() {
                                  if (selected) {
                                    _invitedBrandCategories.add(category);
                                  } else {
                                    _invitedBrandCategories.remove(category);
                                  }
                                });
                              },
                            );
                          }).toList(),
                        ),
                        SwitchListTile(
                          title: const Text('Requires Lookbook'),
                          value: _requiresLookbook,
                          onChanged: (value) => setState(() => _requiresLookbook = value),
                        ),
                        DropdownButtonFormField<String>(
                          value: _stallStructure,
                          decoration: const InputDecoration(labelText: 'Stall Structure'),
                          items: ['standard', 'premium', 'luxury']
                              .map((type) => DropdownMenuItem(
                                    value: type,
                                    child: Text(type.capitalize()),
                                  ))
                              .toList(),
                          onChanged: (value) => setState(() => _stallStructure = value!),
                        ),
                        TextFormField(
                          initialValue: _stallCount.toString(),
                          decoration: const InputDecoration(labelText: 'Number of Stalls'),
                          keyboardType: TextInputType.number,
                          onChanged: (value) => setState(() => _stallCount = int.tryParse(value) ?? 0),
                        ),
                        Wrap(
                          spacing: 8.0,
                          children: [
                            'Small',
                            'Medium',
                            'Large',
                            'XL',
                          ].map((size) {
                            final isSelected = _stallSizes.contains(size);
                            return FilterChip(
                              label: Text(size),
                              selected: isSelected,
                              onSelected: (selected) {
                                setState(() {
                                  if (selected) {
                                    _stallSizes.add(size);
                                  } else {
                                    _stallSizes.remove(size);
                                  }
                                });
                              },
                            );
                          }).toList(),
                        ),
                        DropdownButtonFormField<String>(
                          value: _bookingType,
                          decoration: const InputDecoration(labelText: 'Booking Type'),
                          items: ['first-come-first-serve', 'auction', 'invite-only']
                              .map((type) => DropdownMenuItem(
                                    value: type,
                                    child: Text(type.capitalize()),
                                  ))
                              .toList(),
                          onChanged: (value) => setState(() => _bookingType = value!),
                        ),
                      ],
                    ),
                    isActive: _currentStep >= 1,
                  ),
                  Step(
                    title: const Text('Organizer Details'),
                    content: Column(
                      children: [
                        TextFormField(
                          controller: _organizerNameController,
                          decoration: const InputDecoration(labelText: 'Organizer Name'),
                          validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
                        ),
                        TextFormField(
                          controller: _organizerContactController,
                          decoration: const InputDecoration(labelText: 'Contact Number'),
                          keyboardType: TextInputType.phone,
                          validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
                        ),
                        TextFormField(
                          controller: _organizerAltContactController,
                          decoration: const InputDecoration(labelText: 'Alternate Contact Number'),
                          keyboardType: TextInputType.phone,
                        ),
                        TextFormField(
                          controller: _organizerEmailController,
                          decoration: const InputDecoration(labelText: 'Email'),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
                        ),
                      ],
                    ),
                    isActive: _currentStep >= 2,
                  ),
                ],
              ),
            ),
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
} 