import 'package:flutter/material.dart';

class ExhibitionLayout {
  final String id;
  final String exhibitionId;
  final String name;
  final double totalWidth;
  final double totalHeight;
  final List<Stall> stalls;
  final List<Facility> facilities;
  final String? logoUrl;
  final String? coverUrl;
  final List<String> mediaGallery;

  ExhibitionLayout({
    required this.id,
    required this.exhibitionId,
    required this.name,
    required this.totalWidth,
    required this.totalHeight,
    required this.stalls,
    required this.facilities,
    this.logoUrl,
    this.coverUrl,
    this.mediaGallery = const [],
  });

  double get totalArea => totalWidth * totalHeight;
  double get usedArea => stalls.fold<double>(0, (sum, stall) => sum + stall.area) + 
                        facilities.fold<double>(0, (sum, facility) => sum + facility.area);
  double get availableArea => totalArea - usedArea;
}

class Stall {
  final String id;
  final String name;
  final double width;
  final double height;
  double x;
  double y;
  String status;
  String? bookedBy;
  final double price;

  Stall({
    required this.id,
    required this.name,
    required this.width,
    required this.height,
    required this.x,
    required this.y,
    this.status = 'available',
    this.bookedBy,
    required this.price,
  });

  double get area => width * height;
  Rect get rect => Rect.fromLTWH(x, y, width, height);
}

class Facility {
  final String id;
  final String name;
  final FacilityType type;
  final double width;
  final double height;
  double x;
  double y;

  Facility({
    required this.id,
    required this.name,
    required this.type,
    required this.width,
    required this.height,
    required this.x,
    required this.y,
  });

  double get area => width * height;
  Rect get rect => Rect.fromLTWH(x, y, width, height);
}

enum FacilityType {
  restroom,
  hall,
  walkingArea,
  diningArea,
  cafe,
  entrance,
  exit,
  informationDesk,
  other
} 