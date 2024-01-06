import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:twg/core/dtos/apply/apply_dto.dart';
import 'package:twg/core/dtos/apply/create_apply_dto.dart';
import 'package:twg/core/dtos/apply/update_apply_dto.dart';
import 'package:twg/core/dtos/booking/booking_dto.dart';
import 'package:twg/core/dtos/osrm/osrm_response_dto.dart';

abstract class IApplyViewModel implements ChangeNotifier {
  List<ApplyDto> get applys;
  double? get zoomLevel;
  LatLng? get center;
  bool get isLoading;
  String? get keyword;
  BookingDto? get bookingDto;
  set currentLocation(LatLng? location);
  set currentDestination(LatLng? destination);
  LatLng? get currentLocation;
  LatLng? get currentDestination;
  DirectionDto? get currentDirection;
  LatLngBounds? get boundConfirmScreen;
  void setBookingDto(BookingDto value);
  Future<void> init(String status);
  Future<void> getMoreApplys(String status);
  Future<void> createApply(CreateApplyDto value);
  Future<void> updateApply(String id, UpdateApplyDto value);
  Future<void> delayedFunctionCaller();
  bool get isMyApplys;
  void setIsMyApplys(bool value);

  List<ApplyDto> get applysAfterFilter;
  void setStartPoint(String value);
  void setEndPoint(String value);
  void setApplyerName(String value);
  Future<void> updateRoute(LatLng currentPlace);
  void initSocketEventForApply();
  Future<void> initNavigation(BookingDto bookingDto);
}
