import 'package:cloud_firestore/cloud_firestore.dart';

class ExhibitionModel {
  final String id;
  final String name;
  final String description;
  final String shortDescription;
  final String venueLocation;
  final String pinCode;
  final int expectedFootfall;
  final String venueType;
  final String timingType;
  final List<String> invitedBrandCategories;
  final bool requiresLookbook;
  final String stallStructure;
  final int stallCount;
  final List<String> stallSizes;
  final String bookingType;
  final Map<String, double> pricing;
  final String organizerName;
  final String organizerContact;
  final String organizerAltContact;
  final String organizerEmail;
  final String organizerId;
  final DateTime startDate;
  final DateTime endDate;
  final String status;
  final List<String> galleryImages;
  final String? logoUrl;
  final String? coverUrl;
  final String? venueLayoutUrl;
  final DateTime createdAt;
  final DateTime updatedAt;

  ExhibitionModel({
    required this.id,
    required this.name,
    required this.description,
    required this.shortDescription,
    required this.venueLocation,
    required this.pinCode,
    required this.expectedFootfall,
    required this.venueType,
    required this.timingType,
    required this.invitedBrandCategories,
    required this.requiresLookbook,
    required this.stallStructure,
    required this.stallCount,
    required this.stallSizes,
    required this.bookingType,
    required this.pricing,
    required this.organizerName,
    required this.organizerContact,
    required this.organizerAltContact,
    required this.organizerEmail,
    required this.organizerId,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.galleryImages,
    this.logoUrl,
    this.coverUrl,
    this.venueLayoutUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ExhibitionModel.fromJson(Map<String, dynamic> json) {
    return ExhibitionModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      shortDescription: json['shortDescription'] as String,
      venueLocation: json['venueLocation'] as String,
      pinCode: json['pinCode'] as String,
      expectedFootfall: json['expectedFootfall'] as int,
      venueType: json['venueType'] as String,
      timingType: json['timingType'] as String,
      invitedBrandCategories: List<String>.from(json['invitedBrandCategories']),
      requiresLookbook: json['requiresLookbook'] as bool,
      stallStructure: json['stallStructure'] as String,
      stallCount: json['stallCount'] as int,
      stallSizes: List<String>.from(json['stallSizes']),
      bookingType: json['bookingType'] as String,
      pricing: Map<String, double>.from(json['pricing']),
      organizerName: json['organizerName'] as String,
      organizerContact: json['organizerContact'] as String,
      organizerAltContact: json['organizerAltContact'] as String,
      organizerEmail: json['organizerEmail'] as String,
      organizerId: json['organizerId'] as String,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      status: json['status'] as String,
      galleryImages: List<String>.from(json['galleryImages']),
      logoUrl: json['logoUrl'] as String?,
      coverUrl: json['coverUrl'] as String?,
      venueLayoutUrl: json['venueLayoutUrl'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'shortDescription': shortDescription,
      'venueLocation': venueLocation,
      'pinCode': pinCode,
      'expectedFootfall': expectedFootfall,
      'venueType': venueType,
      'timingType': timingType,
      'invitedBrandCategories': invitedBrandCategories,
      'requiresLookbook': requiresLookbook,
      'stallStructure': stallStructure,
      'stallCount': stallCount,
      'stallSizes': stallSizes,
      'bookingType': bookingType,
      'pricing': pricing,
      'organizerName': organizerName,
      'organizerContact': organizerContact,
      'organizerAltContact': organizerAltContact,
      'organizerEmail': organizerEmail,
      'organizerId': organizerId,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'status': status,
      'galleryImages': galleryImages,
      'logoUrl': logoUrl,
      'coverUrl': coverUrl,
      'venueLayoutUrl': venueLayoutUrl,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  ExhibitionModel copyWith({
    String? id,
    String? name,
    String? description,
    String? shortDescription,
    String? venueLocation,
    String? pinCode,
    int? expectedFootfall,
    String? venueType,
    String? timingType,
    List<String>? invitedBrandCategories,
    bool? requiresLookbook,
    String? stallStructure,
    int? stallCount,
    List<String>? stallSizes,
    String? bookingType,
    Map<String, double>? pricing,
    String? organizerName,
    String? organizerContact,
    String? organizerAltContact,
    String? organizerEmail,
    String? organizerId,
    DateTime? startDate,
    DateTime? endDate,
    String? status,
    List<String>? galleryImages,
    String? logoUrl,
    String? coverUrl,
    String? venueLayoutUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ExhibitionModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      shortDescription: shortDescription ?? this.shortDescription,
      venueLocation: venueLocation ?? this.venueLocation,
      pinCode: pinCode ?? this.pinCode,
      expectedFootfall: expectedFootfall ?? this.expectedFootfall,
      venueType: venueType ?? this.venueType,
      timingType: timingType ?? this.timingType,
      invitedBrandCategories: invitedBrandCategories ?? this.invitedBrandCategories,
      requiresLookbook: requiresLookbook ?? this.requiresLookbook,
      stallStructure: stallStructure ?? this.stallStructure,
      stallCount: stallCount ?? this.stallCount,
      stallSizes: stallSizes ?? this.stallSizes,
      bookingType: bookingType ?? this.bookingType,
      pricing: pricing ?? this.pricing,
      organizerName: organizerName ?? this.organizerName,
      organizerContact: organizerContact ?? this.organizerContact,
      organizerAltContact: organizerAltContact ?? this.organizerAltContact,
      organizerEmail: organizerEmail ?? this.organizerEmail,
      organizerId: organizerId ?? this.organizerId,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      status: status ?? this.status,
      galleryImages: galleryImages ?? this.galleryImages,
      logoUrl: logoUrl ?? this.logoUrl,
      coverUrl: coverUrl ?? this.coverUrl,
      venueLayoutUrl: venueLayoutUrl ?? this.venueLayoutUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
} 