import 'package:flutter/material.dart';
import 'package:twg/core/dtos/booking/booking_dto.dart';
import 'package:twg/core/services/interfaces/ibooking_service.dart';
import 'package:twg/core/view_models/interfaces/ibooking_viewmodel.dart';
import 'package:twg/global/locator.dart';

class BookingViewModel with ChangeNotifier implements IBookingViewModel {
  List<BookingDto> _bookings = [];
  int _totalCount = 0;
  bool _isLoading = false;
  int page = 1;
  String? _keyword;

  final IBookingService _iBookingService = locator<IBookingService>();
  BookingDto? _bookingDto;

  @override
  BookingDto? get bookingDto => _bookingDto;

  @override
  List<BookingDto> get bookings => _bookings;
  @override
  String? get keyword => _keyword;
  @override
  bool get isLoading => _isLoading;

  bool _isMyList = false;
  @override
  bool get isMyList => _isMyList;
  @override
  void setIsMyList(bool value) {
    _isMyList = value;
  }

  void _reset() {
    _keyword = null;
    page = 1;
    _bookings.clear();
  }

  @override
  Future<void> init(String status) async {
    _reset();
    final paginationProducts = await _iBookingService.getBookings(
      status: status,
      page: 1,
      pageSize: 10,
    );
    _bookings = paginationProducts ?? [];
    _totalCount = _iBookingService.total;
    notifyListeners();
  }

  @override
  Future<void> getMoreBookings(String status) async {
    if (_totalCount == 0) {
      return;
    }
    _isLoading = true;
    notifyListeners();

    final paginationBookings = await _iBookingService.getBookings(
      status: status,
      page: page,
      pageSize: page * 10,
    );

    _bookings.addAll(
      paginationBookings ?? [],
    );
    _totalCount = _iBookingService.total;
    page += 1;
    _isLoading = false;
    notifyListeners();
  }

  void _resetMyBookings() {
    _keyword = null;
    page = 1;
    _bookings.clear();
  }

  @override
  Future<void> initMyBookings() async {
    _resetMyBookings();
    final paginationProducts = await _iBookingService.getMyBookings(
      page: 1,
      pageSize: 10,
    );
    _bookings = paginationProducts ?? [];
    _totalCount = _iBookingService.total;
    notifyListeners();
  }

  @override
  Future<void> getMoreMyBookings() async {
    if (_totalCount == 0) {
      return;
    }
    _isLoading = true;
    notifyListeners();

    final paginationBookings = await _iBookingService.getMyBookings(
      page: page,
      pageSize: page * 10,
    );

    _bookings.addAll(
      paginationBookings ?? [],
    );
    _totalCount = _iBookingService.total;
    page += 1;
    _isLoading = false;
    notifyListeners();
  }
}
