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

  factory StallLayoutModel.fromJson(Map<String, dynamic> json) {
    return StallLayoutModel(
      id: json['id'] as String,
      exhibitionId: json['exhibitionId'] as String,
      name: json['name'] as String,
      rows: json['rows'] as int,
      columns: json['columns'] as int,
      stalls: (json['stalls'] as List)
          .map((e) => StallPosition.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'exhibitionId': exhibitionId,
      'name': name,
      'rows': rows,
      'columns': columns,
      'stalls': stalls.map((e) => e.toJson()).toList(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}

class StallPosition {
  final int row;
  final int column;
  final String? stallId;
  final String? stallSize;
  final String? exhibitorId;
  final bool isAvailable;
  final bool isEntrance;
  final bool isExit;
  final bool isRestroom;
  final bool isFoodCourt;

  StallPosition({
    required this.row,
    required this.column,
    this.stallId,
    this.stallSize,
    this.exhibitorId,
    this.isAvailable = true,
    this.isEntrance = false,
    this.isExit = false,
    this.isRestroom = false,
    this.isFoodCourt = false,
  });

  factory StallPosition.fromJson(Map<String, dynamic> json) {
    return StallPosition(
      row: json['row'] as int,
      column: json['column'] as int,
      stallId: json['stallId'] as String?,
      stallSize: json['stallSize'] as String?,
      exhibitorId: json['exhibitorId'] as String?,
      isAvailable: json['isAvailable'] as bool? ?? true,
      isEntrance: json['isEntrance'] as bool? ?? false,
      isExit: json['isExit'] as bool? ?? false,
      isRestroom: json['isRestroom'] as bool? ?? false,
      isFoodCourt: json['isFoodCourt'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'row': row,
      'column': column,
      'stallId': stallId,
      'stallSize': stallSize,
      'exhibitorId': exhibitorId,
      'isAvailable': isAvailable,
      'isEntrance': isEntrance,
      'isExit': isExit,
      'isRestroom': isRestroom,
      'isFoodCourt': isFoodCourt,
    };
  }
} 