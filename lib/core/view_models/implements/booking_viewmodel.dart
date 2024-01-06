import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:twg/core/dtos/booking/booking_dto.dart';
import 'package:twg/core/dtos/goongs/place_detail_dto.dart';
import 'package:twg/core/dtos/goongs/place_dto.dart';
import 'package:twg/core/dtos/goongs/predictions_dto.dart';
import 'package:twg/core/dtos/osrm/osrm_response_dto.dart';
import 'package:twg/core/services/interfaces/ibooking_service.dart';
import 'package:twg/core/services/interfaces/igoong_service.dart';
import 'package:twg/core/services/interfaces/iors_service.dart';
import 'package:twg/core/view_models/interfaces/ibooking_viewmodel.dart';
import 'package:twg/global/locator.dart';
import 'package:twg/global/router.dart';

class BookingViewModel with ChangeNotifier implements IBookingViewModel {
  List<BookingDto> _bookings = [];
  int _totalCount = 0;
  bool _isLoading = false;
  int page = 1;
  String? _keyword;

  final IBookingService _iBookingService = locator<IBookingService>();
  final IGoongService _iGoongService = locator<IGoongService>();
  final IOrsService _iOrsService = locator<IOrsService>();

  BookingDto? _bookingDto;
  bool _onChangePlace = false;
  bool _onSearchPlace = false;
  List<Predictions> _listPredictions = [];

  bool _loadingFromMap = false;

  LatLng? _currentLocation;
  LatLng? _currentDestination;
  DirectionDto? _currentDirection;
  LatLngBounds? _boundConfirmScreen;
  BookingDto? _currentBooking;

  @override
  BookingDto? get currentBooking => _currentBooking;

  @override
  LatLngBounds? get boundConfirmScreen => _boundConfirmScreen;

  @override
  DirectionDto? get currentDirection => _currentDirection;

  @override
  LatLng? get currentLocation => _currentLocation;

  @override
  LatLng? get currentDestination => _currentDestination;

  @override
  set currentLocation(LatLng? location) {
    _currentLocation = location;
    notifyListeners();
  }

  @override
  set currentDestination(LatLng? destination) {
    _currentDestination = destination;
    notifyListeners();
  }

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

  String getNum(String mess) {
    // Tìm và lấy số đầu tiên trong chuỗi
    RegExp regExp = RegExp(r'(\d+)');
    var match = regExp.firstMatch(mess);

    if (match != null) {
      String soDauTien = match.group(0)!;
      return soDauTien; // Kết quả: 15
    } else {
      return '0';
    }
  }

  @override
  Future<void> initConfirmLocation() async {
    if (currentLocation != null && currentDestination != null) {
      _currentDirection = await _iOrsService.getCoordinates(
        currentLocation!,
        currentDestination!,
      );
      _currentBooking!.distance = currentDirection!.distance;
      _currentBooking!.duration = currentDirection!.duration;

      _boundConfirmScreen =
          LatLngBounds.fromPoints(_currentDirection!.coordinates!
              .map(
                (location) => LatLng(
                  location.latitude,
                  location.longitude,
                ),
              )
              .toList());
    }
    notifyListeners();
  }

  @override
  void initData() async {
    _listPredictions.clear();
  }

  @override
  void updateBookingType(String bookingType) {
    _currentBooking = BookingDto(
      status: 'available',
    );
    _currentBooking!.bookingType = bookingType;
    notifyListeners();
  }

  @override
  void updateBookingLocation({
    String? startPointId,
    String? startPointMainText,
    String? startPointAddress,
    String? endPointId,
    String? endPointMainText,
    String? endPointAddress,
  }) {
    _currentBooking!.startPointLat = currentLocation!.latitude.toString();
    _currentBooking!.startPointLong = currentLocation!.longitude.toString();
    _currentBooking!.endPointLat = currentDestination!.latitude.toString();
    _currentBooking!.endPointLong = currentDestination!.longitude.toString();
    _currentBooking!.startPointId = startPointId;
    _currentBooking!.startPointAddress = startPointAddress;
    _currentBooking!.startPointMainText = startPointMainText;
    _currentBooking!.endPointId = endPointId;
    _currentBooking!.endPointAddress = endPointAddress;
    _currentBooking!.endPointMainText = endPointMainText;
    ;
    notifyListeners();
  }

  @override
  Future<void> createBooking(
      {String? time, String? price, String? content}) async {
    _currentBooking!.time = time;
    _currentBooking!.price = int.parse(
      price!.replaceAll(RegExp(r'[^0-9]'), '').trim(),
    );
    _currentBooking!.content = content;
    final isCreateSuccess =
        await _iBookingService.createBooking(_currentBooking!);
    if (isCreateSuccess) {
      Get.toNamed(MyRouter.home);
    } else {
      EasyLoading.showError('Đăng bài thất bại');
    }
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

  @override
  Future<void> saveLocation(Predictions location) async {
    await _iBookingService.saveLocation(location);
  }

  @override
  Future<void> getSaveLocation() async {
    _resetMyBookings();
    final paginationProducts = await _iBookingService.getMyBookings(
      page: 1,
      pageSize: 10,
    );
    _bookings = paginationProducts ?? [];
    _totalCount = _iBookingService.total;
    notifyListeners();
  }
}
