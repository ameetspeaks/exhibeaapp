import '../models/exhibition_model.dart';
import '../models/stall_model.dart';
import 'auth_service.dart';

class ExhibitionService {
  static bool useMockData = true; // Always true for now
  final AuthService _authService = AuthService();

  // Mock exhibitions for development
  static final List<ExhibitionModel> _mockExhibitions = [
    ExhibitionModel(
      id: '1',
      name: 'Fashion Week 2023',
      description: 'Annual fashion exhibition showcasing latest trends',
      shortDescription: 'Annual fashion exhibition',
      venueLocation: 'Convention Center',
      pinCode: '400001',
      expectedFootfall: 10000,
      venueType: 'Indoor',
      timingType: 'Day',
      invitedBrandCategories: ['Fashion', 'Beauty'],
      requiresLookbook: true,
      stallStructure: 'Standard',
      stallCount: 50,
      stallSizes: ['6x6', '8x8'],
      bookingType: 'Fixed',
      pricing: {'standard': 5000.0},
      organizerName: 'Fashion Events Ltd',
      organizerContact: '9876543210',
      organizerAltContact: '9876543211',
      organizerEmail: 'contact@fashionevents.com',
      organizerId: 'org1',
      startDate: DateTime.now().add(const Duration(days: 30)),
      endDate: DateTime.now().add(const Duration(days: 35)),
      status: 'Active',
      galleryImages: [],
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    ExhibitionModel(
      id: '2',
      name: 'Fashion Week 2024',
      shortDescription: 'International fashion exhibition',
      description: 'Showcasing the latest trends in fashion and design',
      venueType: 'indoor',
      venueLocation: 'Fashion Center, Paris',
      pinCode: '75001',
      startDate: DateTime.now().add(const Duration(days: 45)),
      endDate: DateTime.now().add(const Duration(days: 48)),
      timingType: 'fixed',
      expectedFootfall: 3000,
      stallStructure: 'premium',
      stallCount: 50,
      bookingType: 'invitation-only',
      invitedBrandCategories: ['Fashion', 'Luxury', 'Design'],
      stallSizes: ['Medium', 'Large'],
      status: 'upcoming',
      organizerId: 'mock_user_id',
      organizerName: 'Fashion Events Ltd.',
      organizerContact: '+33 1 23 45 67 89',
      organizerAltContact: '+33 1 23 45 67 90',
      organizerEmail: 'contact@fashionevents.com',
      requiresLookbook: true,
      pricing: {
        'Medium': 3000.0,
        'Large': 5000.0,
      },
      galleryImages: [
        'https://example.com/fashion1.jpg',
        'https://example.com/fashion2.jpg',
      ],
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
  ];

  // Get all exhibitions
  Future<List<ExhibitionModel>> getExhibitions() async {
    // In a real app, this would make an API call
    await Future.delayed(const Duration(seconds: 1));
    return _mockExhibitions;
  }

  // Get exhibition by ID
  Future<ExhibitionModel?> getExhibitionById(String id) async {
    // In a real app, this would make an API call
    await Future.delayed(const Duration(seconds: 1));
    return _mockExhibitions.firstWhere(
      (e) => e.id == id,
      orElse: () => throw Exception('Exhibition not found'),
    );
  }

  // Get exhibitions by organizer ID
  Future<List<ExhibitionModel>> getExhibitionsByOrganizer(String organizerId) async {
    return _mockExhibitions.where((exhibition) => exhibition.organizerId == organizerId).toList();
  }

  // Create new exhibition
  Future<ExhibitionModel> createExhibition(ExhibitionModel exhibition) async {
    // In a real app, this would make an API call
    await Future.delayed(const Duration(seconds: 1));
    _mockExhibitions.add(exhibition);
    return exhibition;
  }

  // Update exhibition
  Future<ExhibitionModel> updateExhibition(ExhibitionModel exhibition) async {
    // In a real app, this would make an API call
    await Future.delayed(const Duration(seconds: 1));
    final index = _mockExhibitions.indexWhere((e) => e.id == exhibition.id);
    if (index != -1) {
      _mockExhibitions[index] = exhibition;
    }
    return exhibition;
  }

  // Delete exhibition
  Future<void> deleteExhibition(String id) async {
    return;
  }
} 