import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:twg/core/dtos/booking/booking_dto.dart';
import 'package:twg/core/dtos/goongs/place_detail_dto.dart';
import 'package:twg/core/dtos/goongs/place_dto.dart';
import 'package:twg/core/dtos/goongs/predictions_dto.dart';
import 'package:twg/core/dtos/osrm/osrm_response_dto.dart';

abstract class IBookingViewModel implements ChangeNotifier {
  List<BookingDto> get bookings;
  bool get isLoading;
  bool get loadingFromMap;
  bool get onSearchPlace;
  bool get onChangePlace;
  set currentLocation(LatLng? location);
  set currentDestination(LatLng? destination);
  LatLng? get currentLocation;
  LatLng? get currentDestination;
  DirectionDto? get currentDirection;
  LatLngBounds? get boundConfirmScreen;
  List<Predictions> get listPredictions;
  BookingDto? get currentBooking;
  Future<void> createBooking({String? time, String? price, String? content});
  void updateBookingType(String bookingType);
  void updateBookingLocation({
    String? startPointId,
    String? startPointMainText,
    String? startPointAddress,
    String? endPointId,
    String? endPointMainText,
    String? endPointAddress,
  });
  void initData();
  Future<void> initConfirmLocation();
  bool get isMyList;
  void setIsMyList(bool value);
  String? get keyword;
  Future<void> init(String status);
  Future<void> getMoreBookings(String status);
  Future<void> initMyBookings();
  Future<void> getMoreMyBookings();
  Future<void> onPickPlace(String keyWord);
  Future<PlaceDto?> getPlaceById(String locationId);
  Future<List<PlaceDetailDto>?> getPlaceByGeocode(LatLng latLng);
  Future<void> saveLocation(Predictions location);
}
