import 'package:flutter/material.dart';
import 'package:twg/core/dtos/booking/booking_dto.dart';

abstract class IBookingViewModel implements ChangeNotifier {
  List<BookingDto> get bookings;
  bool get isLoading;
  String? get keyword;
  Future<void> init(String status);
  Future<void> getMoreBookings(String status);
}
