class Booking {
  final String id;
  final String customerName;
  final String customerEmail;
  final String customerPhone;
  final String exhibitionId;
  final String exhibitionName;
  final String venue;
  final DateTime date;
  final String time;
  final String stallNumber;
  final String status;
  final double amount;
  final String paymentMethod;

  Booking({
    required this.id,
    required this.customerName,
    required this.customerEmail,
    required this.customerPhone,
    required this.exhibitionId,
    required this.exhibitionName,
    required this.venue,
    required this.date,
    required this.time,
    required this.stallNumber,
    required this.status,
    required this.amount,
    required this.paymentMethod,
  });

  factory Booking.fromMap(Map<String, dynamic> map) {
    return Booking(
      id: map['id'] as String,
      customerName: map['customerName'] as String,
      customerEmail: map['customerEmail'] as String,
      customerPhone: map['customerPhone'] as String,
      exhibitionId: map['exhibitionId'] as String,
      exhibitionName: map['exhibitionName'] as String,
      venue: map['venue'] as String,
      date: DateTime.parse(map['date'] as String),
      time: map['time'] as String,
      stallNumber: map['stallNumber'] as String,
      status: map['status'] as String,
      amount: (map['amount'] as num).toDouble(),
      paymentMethod: map['paymentMethod'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'customerName': customerName,
      'customerEmail': customerEmail,
      'customerPhone': customerPhone,
      'exhibitionId': exhibitionId,
      'exhibitionName': exhibitionName,
      'venue': venue,
      'date': date.toIso8601String(),
      'time': time,
      'stallNumber': stallNumber,
      'status': status,
      'amount': amount,
      'paymentMethod': paymentMethod,
    };
  }
} 