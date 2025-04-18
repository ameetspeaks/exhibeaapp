class StallPosition {
  final int row;
  final int column;
  final bool isEntrance;
  final bool isExit;
  final bool isRestroom;
  final bool isFoodCourt;
  final bool isAvailable;
  final String? stallSize;

  StallPosition({
    required this.row,
    required this.column,
    this.isEntrance = false,
    this.isExit = false,
    this.isRestroom = false,
    this.isFoodCourt = false,
    this.isAvailable = true,
    this.stallSize,
  });
}

class StallLayoutModel {
  final String id;
  final String exhibitionId;
  final String name;
  final int rows;
  final int columns;
  final List<StallPosition> stalls;
  final DateTime createdAt;
  final DateTime updatedAt;

  StallLayoutModel({
    required this.id,
    required this.exhibitionId,
    required this.name,
    required this.rows,
    required this.columns,
    required this.stalls,
    required this.createdAt,
    required this.updatedAt,
  });
}

class Stall {
  final String id;
  final String number;
  final String size;
  final double price;
  final String status;
  final String type;
  final String? brand;

  Stall({
    required this.id,
    required this.number,
    required this.size,
    required this.price,
    required this.status,
    required this.type,
    this.brand,
  });
} 