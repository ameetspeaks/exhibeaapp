import 'package:uuid/uuid.dart';
import '../models/booking_model.dart';

class BookingService {
  static bool useMockData = true;

  // Mock data for development
  final List<BookingModel> _mockBookings = [
    BookingModel(
      id: '1',
      exhibitionId: '1',
      exhibitionName: 'Fashion Week 2023',
      brandId: 'brand1',
      brandName: 'Fashion Forward',
      numberOfStalls: 2,
      stallSize: '10x10',
      amount: 5000.0,
      totalAmount: 10000.0,
      status: 'Confirmed',
      paymentStatus: 'Paid',
      bookingDate: DateTime.now().subtract(const Duration(days: 5)),
      notes: 'Special requirements: Need extra lighting',
      additionalInfo: {'stallNumbers': ['A1', 'A2']},
      createdAt: DateTime.now().subtract(const Duration(days: 5)),
      updatedAt: DateTime.now().subtract(const Duration(days: 5)),
    ),
    BookingModel(
      id: '2',
      exhibitionId: '1',
      exhibitionName: 'Fashion Week 2023',
      brandId: 'brand2',
      brandName: 'Style Hub',
      numberOfStalls: 1,
      stallSize: '10x10',
      amount: 5000.0,
      totalAmount: 5000.0,
      status: 'Pending',
      paymentStatus: 'Pending',
      bookingDate: DateTime.now().subtract(const Duration(days: 2)),
      notes: 'Waiting for approval',
      additionalInfo: {'stallNumbers': ['B1']},
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
      updatedAt: DateTime.now().subtract(const Duration(days: 2)),
    ),
    BookingModel(
      id: '3',
      exhibitionId: '2',
      exhibitionName: 'Fashion Week 2024',
      brandId: 'brand3',
      brandName: 'Luxury Brands',
      numberOfStalls: 3,
      stallSize: '10x10',
      amount: 5000.0,
      totalAmount: 15000.0,
      status: 'Confirmed',
      paymentStatus: 'Paid',
      bookingDate: DateTime.now().subtract(const Duration(days: 1)),
      notes: 'VIP section required',
      additionalInfo: {'stallNumbers': ['C1', 'C2', 'C3']},
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
      updatedAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
  ];

  Future<List<BookingModel>> getBookings() async {
    if (useMockData) {
      return _mockBookings;
    }
    // TODO: Implement actual API call
    return [];
  }

  Future<BookingModel?> getBookingById(String bookingId) async {
    if (useMockData) {
      try {
        return _mockBookings.firstWhere((booking) => booking.id == bookingId);
      } catch (e) {
        return null;
      }
    }
    // TODO: Implement actual API call
    return null;
  }

  Future<List<BookingModel>> getBookingsByExhibitionId(String exhibitionId) async {
    await Future.delayed(const Duration(seconds: 1));
    return _mockBookings.where((booking) => booking.exhibitionId == exhibitionId).toList();
  }

  Future<List<BookingModel>> getBookingsByBrand(String brandId) async {
    await Future.delayed(const Duration(seconds: 1));
    return _mockBookings.where((booking) => booking.brandId == brandId).toList();
  }

  Future<BookingModel> createBooking(BookingModel booking) async {
    await Future.delayed(const Duration(seconds: 1));
    _mockBookings.add(booking);
    return booking;
  }

  Future<BookingModel> updateBooking(BookingModel booking) async {
    await Future.delayed(const Duration(seconds: 1));
    final index = _mockBookings.indexWhere((b) => b.id == booking.id);
    if (index == -1) {
      throw Exception('Booking not found');
    }
    _mockBookings[index] = booking;
    return booking;
  }

  Future<void> deleteBooking(String id) async {
    await Future.delayed(const Duration(seconds: 1));
    _mockBookings.removeWhere((booking) => booking.id == id);
  }

  Future<BookingModel> confirmBooking(String id) async {
    final booking = await getBookingById(id);
    if (booking == null) throw Exception('Booking not found');
    return updateBooking(booking.copyWith(
      status: 'Confirmed',
      updatedAt: DateTime.now(),
    ));
  }

  Future<BookingModel> cancelBooking(String id) async {
    final booking = await getBookingById(id);
    if (booking == null) throw Exception('Booking not found');
    return updateBooking(booking.copyWith(
      status: 'Cancelled',
      updatedAt: DateTime.now(),
    ));
  }

  Future<BookingModel> updateBookingStatus(String bookingId, String status) async {
    await Future.delayed(const Duration(seconds: 1));
    final index = _mockBookings.indexWhere((booking) => booking.id == bookingId);
    if (index != -1) {
      final updatedBooking = _mockBookings[index].copyWith(
        status: status,
        updatedAt: DateTime.now(),
      );
      _mockBookings[index] = updatedBooking;
      return updatedBooking;
    }
    throw Exception('Booking not found');
  }

  Future<BookingModel> updatePaymentStatus(String bookingId, String paymentStatus) async {
    await Future.delayed(const Duration(seconds: 1));
    final index = _mockBookings.indexWhere((booking) => booking.id == bookingId);
    if (index != -1) {
      final updatedBooking = _mockBookings[index].copyWith(
        paymentStatus: paymentStatus,
        updatedAt: DateTime.now(),
      );
      _mockBookings[index] = updatedBooking;
      return updatedBooking;
    }
    throw Exception('Booking not found');
  }
} 