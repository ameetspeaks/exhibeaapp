import '../models/stall_layout_model.dart';

class StallLayoutService {
  // Mock data for development
  final List<StallLayoutModel> _mockLayouts = [
    StallLayoutModel(
      id: '1',
      exhibitionId: '1',
      name: 'Main Hall Layout',
      rows: 5,
      columns: 8,
      stalls: [
        // Row 1
        StallPosition(row: 0, column: 0, isEntrance: true),
        StallPosition(row: 0, column: 1, stallSize: 'Small'),
        StallPosition(row: 0, column: 2, stallSize: 'Medium'),
        StallPosition(row: 0, column: 3, stallSize: 'Large'),
        StallPosition(row: 0, column: 4, stallSize: 'Medium'),
        StallPosition(row: 0, column: 5, stallSize: 'Small'),
        StallPosition(row: 0, column: 6, isRestroom: true),
        StallPosition(row: 0, column: 7, isExit: true),
        // Row 2
        StallPosition(row: 1, column: 0, stallSize: 'Small'),
        StallPosition(row: 1, column: 1, stallSize: 'Medium'),
        StallPosition(row: 1, column: 2, stallSize: 'Large'),
        StallPosition(row: 1, column: 3, stallSize: 'Medium'),
        StallPosition(row: 1, column: 4, stallSize: 'Small'),
        StallPosition(row: 1, column: 5, stallSize: 'Medium'),
        StallPosition(row: 1, column: 6, isFoodCourt: true),
        StallPosition(row: 1, column: 7, stallSize: 'Small'),
        // Row 3
        StallPosition(row: 2, column: 0, stallSize: 'Medium'),
        StallPosition(row: 2, column: 1, stallSize: 'Large'),
        StallPosition(row: 2, column: 2, stallSize: 'Medium'),
        StallPosition(row: 2, column: 3, stallSize: 'Small'),
        StallPosition(row: 2, column: 4, stallSize: 'Medium'),
        StallPosition(row: 2, column: 5, stallSize: 'Large'),
        StallPosition(row: 2, column: 6, isFoodCourt: true),
        StallPosition(row: 2, column: 7, stallSize: 'Medium'),
        // Row 4
        StallPosition(row: 3, column: 0, stallSize: 'Large'),
        StallPosition(row: 3, column: 1, stallSize: 'Medium'),
        StallPosition(row: 3, column: 2, stallSize: 'Small'),
        StallPosition(row: 3, column: 3, stallSize: 'Medium'),
        StallPosition(row: 3, column: 4, stallSize: 'Large'),
        StallPosition(row: 3, column: 5, stallSize: 'Medium'),
        StallPosition(row: 3, column: 6, isRestroom: true),
        StallPosition(row: 3, column: 7, stallSize: 'Large'),
        // Row 5
        StallPosition(row: 4, column: 0, stallSize: 'Medium'),
        StallPosition(row: 4, column: 1, stallSize: 'Small'),
        StallPosition(row: 4, column: 2, stallSize: 'Medium'),
        StallPosition(row: 4, column: 3, stallSize: 'Large'),
        StallPosition(row: 4, column: 4, stallSize: 'Medium'),
        StallPosition(row: 4, column: 5, stallSize: 'Small'),
        StallPosition(row: 4, column: 6, isFoodCourt: true),
        StallPosition(row: 4, column: 7, isExit: true),
      ],
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
  ];

  Future<StallLayoutModel?> getLayoutByExhibitionId(String exhibitionId) async {
    // TODO: Replace with actual API call
    return _mockLayouts.firstWhere(
      (layout) => layout.exhibitionId == exhibitionId,
      orElse: () => _mockLayouts.first, // Fallback to first layout for demo
    );
  }

  Future<List<StallLayoutModel>> getLayouts() async {
    // TODO: Replace with actual API call
    return _mockLayouts;
  }

  Future<StallLayoutModel> createLayout(StallLayoutModel layout) async {
    // TODO: Replace with actual API call
    _mockLayouts.add(layout);
    return layout;
  }

  Future<StallLayoutModel> updateLayout(StallLayoutModel layout) async {
    // TODO: Replace with actual API call
    final index = _mockLayouts.indexWhere((l) => l.id == layout.id);
    if (index != -1) {
      _mockLayouts[index] = layout;
    }
    return layout;
  }

  Future<void> deleteLayout(String id) async {
    // TODO: Replace with actual API call
    _mockLayouts.removeWhere((layout) => layout.id == id);
  }
} 