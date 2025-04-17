import 'package:cloud_firestore/cloud_firestore.dart';

class StallModel {
  final String id;
  final String exhibitionId;
  final String number;
  final String size;
  final double price;
  final bool isBooked;
  final String? bookedBy;
  final String? bookingId;
  final Map<String, dynamic>? additionalInfo;

  StallModel({
    required this.id,
    required this.exhibitionId,
    required this.number,
    required this.size,
    required this.price,
    this.isBooked = false,
    this.bookedBy,
    this.bookingId,
    this.additionalInfo,
  });

  factory StallModel.fromJson(Map<String, dynamic> json) {
    return StallModel(
      id: json['id'],
      exhibitionId: json['exhibitionId'],
      number: json['number'],
      size: json['size'],
      price: json['price'].toDouble(),
      isBooked: json['isBooked'] ?? false,
      bookedBy: json['bookedBy'],
      bookingId: json['bookingId'],
      additionalInfo: json['additionalInfo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'exhibitionId': exhibitionId,
      'number': number,
      'size': size,
      'price': price,
      'isBooked': isBooked,
      'bookedBy': bookedBy,
      'bookingId': bookingId,
      'additionalInfo': additionalInfo,
    };
  }

  StallModel copyWith({
    String? id,
    String? exhibitionId,
    String? number,
    String? size,
    double? price,
    bool? isBooked,
    String? bookedBy,
    String? bookingId,
    Map<String, dynamic>? additionalInfo,
  }) {
    return StallModel(
      id: id ?? this.id,
      exhibitionId: exhibitionId ?? this.exhibitionId,
      number: number ?? this.number,
      size: size ?? this.size,
      price: price ?? this.price,
      isBooked: isBooked ?? this.isBooked,
      bookedBy: bookedBy ?? this.bookedBy,
      bookingId: bookingId ?? this.bookingId,
      additionalInfo: additionalInfo ?? this.additionalInfo,
    );
  }
} 