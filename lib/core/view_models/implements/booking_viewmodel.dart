import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:twg/core/dtos/booking/booking_dto.dart';
import 'package:twg/core/dtos/goongs/place_detail_dto.dart';
import 'package:twg/core/dtos/goongs/place_dto.dart';
import 'package:twg/core/dtos/goongs/predictions_dto.dart';
import 'package:twg/core/services/interfaces/ibooking_service.dart';
import 'package:twg/core/services/interfaces/igoong_service.dart';
import 'package:twg/core/view_models/interfaces/ibooking_viewmodel.dart';
import 'package:twg/global/locator.dart';

class BookingViewModel with ChangeNotifier implements IBookingViewModel {
  List<BookingDto> _bookings = [];
  int _totalCount = 0;
  bool _isLoading = false;
  int page = 1;
  String? _keyword;

  final IBookingService _iBookingService = locator<IBookingService>();
  final IGoongService _iGoongService = locator<IGoongService>();

  BookingDto? _bookingDto;
  bool _onChangePlace = false;
  bool _onSearchPlace = false;
  List<Predictions> _listPredictions = [];

  bool _loadingFromMap = false;
  @override
  bool get loadingFromMap => _loadingFromMap;

  @override
  bool get onSearchPlace => _onSearchPlace;

  @override
  bool get onChangePlace => _onChangePlace;

  @override
  List<Predictions> get listPredictions => _listPredictions;

  @override
  BookingDto? get bookingDto => _bookingDto;

  @override
  List<BookingDto> get bookings => _bookings;
  @override
  String? get keyword => _keyword;
  @override
  bool get isLoading => _isLoading;
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
  void initData() async {
    _listPredictions.clear();
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

  @override
  Future<void> onPickPlace(String keyWord) async {
    _listPredictions.clear();
    _onSearchPlace = true;
    notifyListeners();
    final predictions = await _iGoongService.searchPlace(keyWord);
    _listPredictions = predictions ?? [];
    _onSearchPlace = false;
    notifyListeners();
  }

  @override
  Future<PlaceDto?> getPlaceById(String locationId) async {
    return await _iGoongService.getPlaceById(locationId);
  }

  @override
  Future<List<PlaceDetailDto>?> getPlaceByGeocode(LatLng latLng) async {
    _onChangePlace = true;
    notifyListeners();
    List<PlaceDetailDto>? placeDetailDto =
        await _iGoongService.getPlaceByGeocode(latLng);
    _onChangePlace = false;
    notifyListeners();
    return placeDetailDto;
  }
}
