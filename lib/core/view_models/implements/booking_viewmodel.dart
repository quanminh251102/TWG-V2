import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:twg/core/dtos/booking/booking_dto.dart';
import 'package:twg/core/dtos/booking/filter_booking_dto.dart';
import 'package:twg/core/dtos/goongs/place_detail_dto.dart';
import 'package:twg/core/dtos/goongs/place_dto.dart';
import 'package:twg/core/dtos/goongs/predictions_dto.dart';
import 'package:twg/core/dtos/location/location_dto.dart';
import 'package:twg/core/dtos/osrm/osrm_response_dto.dart';
import 'package:twg/core/services/interfaces/ibooking_service.dart';
import 'package:twg/core/services/interfaces/igoong_service.dart';
import 'package:twg/core/services/interfaces/iors_service.dart';
import 'package:twg/core/view_models/interfaces/ibooking_viewmodel.dart';
import 'package:twg/global/locator.dart';
import 'package:twg/global/router.dart';

class BookingViewModel with ChangeNotifier implements IBookingViewModel {
  List<BookingDto> _recommendBooking = [];
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
  List<PlaceDetailDto>? _recommendPlaces;
  @override
  List<PlaceDetailDto>? get recommendPlaces => _recommendPlaces;
  bool _onSearchPlace = false;
  List<Predictions> _listPredictions = [];

  bool _loadingFromMap = false;

  LatLng? _currentLocation;
  LatLng? _currentDestination;
  DirectionDto? _currentDirection;
  LatLngBounds? _boundConfirmScreen;
  BookingDto? _currentBooking;
  FilterBookingDto? _filterBookingDto;
  @override
  List<BookingDto> get recommendBooking => _recommendBooking;
  @override
  FilterBookingDto? get filterBookingDto => _filterBookingDto;
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
    _recommendBooking.clear();
  }

  @override
  Future<void> init(int status) async {
    _reset();
    _filterBookingDto = FilterBookingDto();
    final paginationProducts = await _iBookingService.getBookings(
      status: status,
      page: page,
      pageSize: 10,
    );
    page += 1;
    _bookings = paginationProducts ?? [];
    _totalCount = _iBookingService.total;
    notifyListeners();
  }

  @override
  Future<void> saveBooking(String bookingId) async {
    if (await _iBookingService.saveBooking(bookingId)) {
      await getBooking(bookingId);
    }
  }

  @override
  Future<void> getBooking(String bookingId) async {
    final paginationProducts =
        await _iBookingService.getBookings(id: bookingId);
    if (paginationProducts != null && paginationProducts.isNotEmpty) {
      var tempBookingIndex = _bookings
          .indexWhere((element) => element.id == paginationProducts[0].id);

      if (tempBookingIndex != -1) {
        _bookings[tempBookingIndex] = paginationProducts[0];
      }
    }
    notifyListeners();
  }

  @override
  Future<void> onSearchBooking() async {
    _reset();
    final paginationProducts = await _iBookingService.getBookings(
      status: _filterBookingDto?.status,
      authorId: _filterBookingDto?.authorId,
      keyword: _filterBookingDto?.keyword,
      bookingType: _filterBookingDto?.bookingType,
      minPrice: _filterBookingDto?.minPrice,
      maxPrice: _filterBookingDto?.maxPrice,
      startAddress: _filterBookingDto?.startAddress,
      endAddress: _filterBookingDto?.endAddress,
      startTime: _filterBookingDto?.startTime,
      endTime: _filterBookingDto?.endTime,
      page: 1,
      pageSize: 10,
    );
    _bookings = paginationProducts ?? [];
    _totalCount = _iBookingService.total;
    notifyListeners();
  }

  @override
  Future<void> onSearchSaveBooking() async {
    _reset();
    final paginationProducts = await _iBookingService.getBookings(
      isFavorite: true,
      status: _filterBookingDto?.status,
      authorId: _filterBookingDto?.authorId,
      keyword: _filterBookingDto?.keyword,
      bookingType: _filterBookingDto?.bookingType,
      minPrice: _filterBookingDto?.minPrice,
      maxPrice: _filterBookingDto?.maxPrice,
      startAddress: _filterBookingDto?.startAddress,
      endAddress: _filterBookingDto?.endAddress,
      startTime: _filterBookingDto?.startTime,
      endTime: _filterBookingDto?.endTime,
      page: 1,
      pageSize: 10,
    );
    _bookings = paginationProducts ?? [];
    _totalCount = _iBookingService.total;
    notifyListeners();
  }

  @override
  Future<void> deleteFilter() async {
    _filterBookingDto = FilterBookingDto();
  }

  @override
  Future<void> updateFilter(FilterBookingDto filterBookingDto) async {
    _filterBookingDto = filterBookingDto;
  }

  @override
  Future<void> initHome(String status) async {
    _reset();
    final paginationProducts = await _iBookingService.getBookings(
      // status: status,
      page: 1,
      pageSize: 200,
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
  Future<void> getRecommendBooking({
    String? type,
    double? startPointLat,
    double? startPointLong,
    double? endPointLat,
    double? endPointLong,
  }) async {
    _reset();
    final paginationRecommendBooking =
        await _iBookingService.getRecommendBooking(
      type: type,
      startPointLat: startPointLat,
      startPointLong: startPointLong,
      endPointLat: endPointLat,
      endPointLong: endPointLong,
    );
    _bookings = paginationRecommendBooking ?? [];
    _totalCount = _iBookingService.total;
    notifyListeners();
  }

  @override
  void initData() async {
    _listPredictions.clear();
  }

  @override
  void updateBookingType(String bookingType) {
    _currentBooking = BookingDto(
      status: 5,
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
    _currentBooking!.startPointLat = currentLocation!.latitude;
    _currentBooking!.startPointLong = currentLocation!.longitude;
    _currentBooking!.endPointLat = currentDestination!.latitude;
    _currentBooking!.endPointLong = currentDestination!.longitude;
    _currentBooking!.startPointId = startPointId;
    _currentBooking!.startPointAddress = startPointAddress;
    _currentBooking!.startPointMainText = startPointMainText;
    _currentBooking!.endPointId = endPointId;
    _currentBooking!.endPointAddress = endPointAddress;
    _currentBooking!.endPointMainText = endPointMainText;

    notifyListeners();
  }

  @override
  Future<void> createBooking(
      {String? time, String? price, String? content}) async {
    _currentBooking!.time = time;
    _currentBooking!.price = double.parse(
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
  Future<void> getMoreBookings({
    int? sortCreatedAt,
    int? sortUpdatedAt,
    int? status,
    String? authorId,
    String? keyword,
    String? bookingType,
    int? minPrice,
    int? maxPrice,
    String? startAddress,
    String? endAddress,
    String? startTime,
    String? endTime,
  }) async {
    if (_totalCount == 0) {
      return;
    }
    _isLoading = true;
    notifyListeners();

    final paginationBookings = await _iBookingService.getBookings(
      status: _filterBookingDto?.status,
      authorId: _filterBookingDto?.authorId,
      keyword: _filterBookingDto?.keyword,
      bookingType: _filterBookingDto?.bookingType,
      minPrice: _filterBookingDto?.minPrice,
      maxPrice: _filterBookingDto?.maxPrice,
      startAddress: _filterBookingDto?.startAddress,
      endAddress: _filterBookingDto?.endAddress,
      startTime: _filterBookingDto?.startTime,
      endTime: _filterBookingDto?.endTime,
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
  Future<void> getMoreSaveBookings({
    int? sortCreatedAt,
    int? sortUpdatedAt,
    int? status,
    String? authorId,
    String? keyword,
    String? bookingType,
    int? minPrice,
    int? maxPrice,
    String? startAddress,
    String? endAddress,
    String? startTime,
    String? endTime,
  }) async {
    if (_totalCount == 0) {
      return;
    }
    _isLoading = true;
    notifyListeners();

    final paginationBookings = await _iBookingService.getSaveBookings(
      status: _filterBookingDto?.status,
      authorId: _filterBookingDto?.authorId,
      keyword: _filterBookingDto?.keyword,
      bookingType: _filterBookingDto?.bookingType,
      minPrice: _filterBookingDto?.minPrice,
      maxPrice: _filterBookingDto?.maxPrice,
      startAddress: _filterBookingDto?.startAddress,
      endAddress: _filterBookingDto?.endAddress,
      startTime: _filterBookingDto?.startTime,
      endTime: _filterBookingDto?.endTime,
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
      pageSize: 100,
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
    _recommendPlaces = placeDetailDto;
    _onChangePlace = false;
    notifyListeners();
    return placeDetailDto;
  }

  @override
  Future<void> saveLocation(LocationDto location) async {
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
