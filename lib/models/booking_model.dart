class BookingModel {
  final String id;
  final String exhibitionId;
  final String exhibitionName;
  final String brandId;
  final String brandName;
  final int numberOfStalls;
  final String stallSize;
  final double amount;
  final double totalAmount;
  final String status;
  final String paymentStatus;
  final DateTime bookingDate;
  final String? notes;
  final Map<String, dynamic>? additionalInfo;
  final DateTime? confirmedDate;
  final DateTime? cancelledDate;
  final String? paymentId;
  final DateTime createdAt;
  final DateTime updatedAt;

  BookingModel({
    required this.id,
    required this.exhibitionId,
    required this.exhibitionName,
    required this.brandId,
    required this.brandName,
    required this.numberOfStalls,
    required this.stallSize,
    required this.amount,
    required this.totalAmount,
    required this.status,
    required this.paymentStatus,
    required this.bookingDate,
    this.notes,
    this.additionalInfo,
    this.confirmedDate,
    this.cancelledDate,
    this.paymentId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      id: json['id'] as String,
      exhibitionId: json['exhibitionId'] as String,
      exhibitionName: json['exhibitionName'] as String,
      brandId: json['brandId'] as String,
      brandName: json['brandName'] as String,
      numberOfStalls: json['numberOfStalls'] as int,
      stallSize: json['stallSize'] as String,
      amount: (json['amount'] as num).toDouble(),
      totalAmount: (json['totalAmount'] as num).toDouble(),
      status: json['status'] as String,
      paymentStatus: json['paymentStatus'] as String,
      bookingDate: DateTime.parse(json['bookingDate'] as String),
      notes: json['notes'] as String?,
      additionalInfo: json['additionalInfo'] as Map<String, dynamic>?,
      confirmedDate: json['confirmedDate'] != null
          ? DateTime.parse(json['confirmedDate'] as String)
          : null,
      cancelledDate: json['cancelledDate'] != null
          ? DateTime.parse(json['cancelledDate'] as String)
          : null,
      paymentId: json['paymentId'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'exhibitionId': exhibitionId,
      'exhibitionName': exhibitionName,
      'brandId': brandId,
      'brandName': brandName,
      'numberOfStalls': numberOfStalls,
      'stallSize': stallSize,
      'amount': amount,
      'totalAmount': totalAmount,
      'status': status,
      'paymentStatus': paymentStatus,
      'bookingDate': bookingDate.toIso8601String(),
      'notes': notes,
      'additionalInfo': additionalInfo,
      'confirmedDate': confirmedDate?.toIso8601String(),
      'cancelledDate': cancelledDate?.toIso8601String(),
      'paymentId': paymentId,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  BookingModel copyWith({
    String? id,
    String? exhibitionId,
    String? exhibitionName,
    String? brandId,
    String? brandName,
    int? numberOfStalls,
    String? stallSize,
    double? amount,
    double? totalAmount,
    String? status,
    String? paymentStatus,
    DateTime? bookingDate,
    String? notes,
    Map<String, dynamic>? additionalInfo,
    DateTime? confirmedDate,
    DateTime? cancelledDate,
    String? paymentId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return BookingModel(
      id: id ?? this.id,
      exhibitionId: exhibitionId ?? this.exhibitionId,
      exhibitionName: exhibitionName ?? this.exhibitionName,
      brandId: brandId ?? this.brandId,
      brandName: brandName ?? this.brandName,
      numberOfStalls: numberOfStalls ?? this.numberOfStalls,
      stallSize: stallSize ?? this.stallSize,
      amount: amount ?? this.amount,
      totalAmount: totalAmount ?? this.totalAmount,
      status: status ?? this.status,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      bookingDate: bookingDate ?? this.bookingDate,
      notes: notes ?? this.notes,
      additionalInfo: additionalInfo ?? this.additionalInfo,
      confirmedDate: confirmedDate ?? this.confirmedDate,
      cancelledDate: cancelledDate ?? this.cancelledDate,
      paymentId: paymentId ?? this.paymentId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
} 