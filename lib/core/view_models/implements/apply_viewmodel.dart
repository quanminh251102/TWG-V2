import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:twg/core/dtos/apply/apply_dto.dart';
import 'package:twg/core/dtos/apply/create_apply_dto.dart';
import 'package:twg/core/dtos/apply/update_apply_dto.dart';
import 'package:twg/core/dtos/booking/booking_dto.dart';
import 'package:twg/core/dtos/osrm/osrm_response_dto.dart';
import 'package:twg/core/services/interfaces/iapply_service.dart';
import 'package:twg/core/services/interfaces/imap_service.dart';
import 'package:twg/core/services/interfaces/iors_service.dart';
import 'package:twg/core/services/interfaces/isocket_service.dart';
import 'package:twg/core/view_models/interfaces/iapply_viewmodel.dart';
import 'package:twg/global/locator.dart';
import 'package:twg/global/router.dart';
import 'package:twg/ui/common_widgets/coming_apply_dialog.dart';
import 'package:twg/ui/utils/notification_utils.dart';

class ApplyViewModel with ChangeNotifier implements IApplyViewModel {
  List<ApplyDto> _applys = [];
  List<ApplyDto> _applysAfterFilter = [];
  @override
  List<ApplyDto> get applysAfterFilter => _applysAfterFilter;

  String _startPoint = '';

  final IOrsService _iOrsService = locator<IOrsService>();
  final IMapService _iMapService = locator<IMapService>();
  final bool _loadingFromMap = false;
  double? _zoomLevel;
  LatLng? _center;
  LatLng? _currentLocation;
  LatLng? _currentDestination;
  DirectionDto? _currentDirection;
  LatLngBounds? _boundConfirmScreen;
  BookingDto? _currentBooking;
  LocationData? _location;

  @override
  set location(LocationData? location) {
    _location = location;
  }

  @override
  double? get zoomLevel => _zoomLevel;

  @override
  BookingDto? get currentBooking => _currentBooking;

  @override
  LatLngBounds? get boundConfirmScreen => _boundConfirmScreen;

  @override
  DirectionDto? get currentDirection => _currentDirection;

  @override
  LatLng? get center => _center;

  @override
  LatLng? get currentLocation => _currentLocation;

  @override
  LatLng? get currentDestination => _currentDestination;

  @override
  set currentLocation(LatLng? location) {
    _currentLocation = location;
  }

  @override
  set currentDestination(LatLng? destination) {
    _currentDestination = destination;
  }

  @override
  set center(LatLng? center) {
    _center = center;
  }

  @override
  set zoomLevel(double? zoomLevel) {
    _zoomLevel = zoomLevel;
  }

  @override
  Future<void> delayedFunctionCaller() async {
    // Completer<void> completer = Completer<void>();

    // void callback() {
    //   completer.complete();
    // }

    // if (!completer.isCompleted) {
    // await completer.future;
    Position? currentPlace = await _iMapService.determinePosition();
    if (currentPlace != null) {
      await updateRoute(LatLng(currentPlace.latitude, currentPlace.longitude));
    }
    // .then((_) => callback());
    // }
  }

  @override
  Future<void> updateRoute(LatLng currentPlace) async {
    currentLocation = currentPlace;
    if (currentLocation != null && currentDestination != null) {
      _currentDirection = await _iOrsService.getCoordinates(
        currentLocation!,
        currentDestination!,
      );
      print('vào 2');
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
    caculateIndex();
    notifyListeners();
  }

  @override
  void setStartPoint(String value) {
    _startPoint = value;
    filter();
    notifyListeners();
  }

  String _endPoint = '';

  @override
  void setEndPoint(String value) {
    _endPoint = value;
    filter();
    notifyListeners();
  }

  String _applyerName = '';
  double calculateZoomLevel(
      double lat1, double lon1, double lat2, double lon2, double screenWidth) {
    const double earthRadius = 6371000;

    double lat1Rad = degreesToRadians(lat1);
    double lon1Rad = degreesToRadians(lon1);
    double lat2Rad = degreesToRadians(lat2);
    double lon2Rad = degreesToRadians(lon2);

    double dLat = lat2Rad - lat1Rad;
    double dLon = lon2Rad - lon1Rad;
    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(lat1Rad) * cos(lat2Rad) * sin(dLon / 2) * sin(dLon / 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    double distance = earthRadius * c;

    double zoomLevel =
        log(screenWidth * screenWidth / (distance * 2 * pi)) / log(2);

    return zoomLevel;
  }

  double degreesToRadians(double degrees) {
    return degrees * (pi / 180);
  }

  void caculateIndex() {
    if (boundConfirmScreen != null) {
      center = LatLng(
        (boundConfirmScreen!.north + boundConfirmScreen!.south) / 2,
        (boundConfirmScreen!.east + boundConfirmScreen!.west) / 2,
      );
    } else {
      center = LatLng(
        (LatLngBounds.fromPoints(
                  [
                    currentLocation!,
                    currentDestination!,
                  ],
                ).north +
                LatLngBounds.fromPoints(
                  [
                    currentLocation!,
                    currentDestination!,
                  ],
                ).south) /
            2,
        (LatLngBounds.fromPoints(
                  [
                    currentLocation!,
                    currentDestination!,
                  ],
                ).east +
                LatLngBounds.fromPoints(
                  [
                    currentLocation!,
                    currentDestination!,
                  ],
                ).west) /
            2,
      );
    }
    zoomLevel = calculateZoomLevel(
          currentLocation!.latitude,
          currentLocation!.longitude,
          currentDestination!.latitude,
          currentDestination!.longitude,
          WidgetsBinding
              .instance.platformDispatcher.views.first.physicalSize.width,
        ) -
        1;
  }

  @override
  Future<void> initNavigation(BookingDto bookingDto) async {
    currentLocation = LatLng(
      bookingDto.startPointLat!,
      bookingDto.startPointLong!,
    );
    currentDestination = LatLng(
      bookingDto.endPointLat!,
      bookingDto.endPointLong!,
    );
    if (currentLocation != null && currentDestination != null) {
      _currentDirection = await _iOrsService.getCoordinates(
        currentLocation!,
        currentDestination!,
      );

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
    caculateIndex();
    notifyListeners();
  }

  @override
  void setApplyerName(String value) {
    _applyerName = value;
    filter();
    notifyListeners();
  }

  int _totalCount = 0;
  bool _isLoading = false;
  int page = 1;
  String? _keyword;

  final IApplyService _iApplyService = locator<IApplyService>();

  BookingDto? _bookingDto;
  @override
  BookingDto? get bookingDto => _bookingDto;

  @override
  void setBookingDto(BookingDto value) {
    _bookingDto = value;
  }

  @override
  List<ApplyDto> get applys => _applys;
  @override
  String? get keyword => _keyword;
  @override
  bool get isLoading => _isLoading;

  bool _isMyApplys = false;
  @override
  bool get isMyApplys => _isMyApplys;
  @override
  void setIsMyApplys(bool value) {
    _isMyApplys = value;
  }

  final ISocketService _iSocketService = locator<ISocketService>();
  @override
  void initSocketEventForApply() {
    _iSocketService.socket!.on("reload_apply", (jsonData) async {
      final jsonValue = json.encode(jsonData);
      final data = json.decode(jsonValue) as Map<String, dynamic>;
      NotifiationUtils().showNotification(
        title: "Thông báo",
        body: data["notification_body"],
      );
      init('');
      print('reload_apply');
    });

    _iSocketService.socket!.on("receive_apply", (jsonData) async {
      print('receive_apply');
      NotifiationUtils().showNotification(
        title: "Thông báo",
        body: "Có người muốn tham gia vào chuyến đi của bạn",
      );
      final jsonValue = json.encode(jsonData);
      final data = json.decode(jsonValue) as Map<String, dynamic>;
      var value = ApplyDto.fromJson(data);

      Get.bottomSheet(
          ComingApplyDialog(
            apply: value,
            setBooking: setBookingDto,
          ),
          isDismissible: false,
          enableDrag: false);
    });
  }

  void filter() {
    _applysAfterFilter = applys.where((apply) {
      String bookingStartpoint =
          apply.booking!.startPointMainText.toString().toLowerCase() +
              apply.booking!.startPointAddress.toString().toLowerCase();
      String bookingEndpoint =
          apply.booking!.endPointMainText.toString().toLowerCase() +
              apply.booking!.endPointAddress.toString().toLowerCase();
      String searchStartpoint = _startPoint.toLowerCase();
      String searchEndpoint = _endPoint.toLowerCase();

      String applyApplyername =
          apply.applyer!.firstName.toString().toLowerCase();
      String searchApplyername = _applyerName.toString().toLowerCase();

      if (bookingStartpoint.contains(searchStartpoint) ||
          bookingEndpoint.contains(searchEndpoint) ||
          applyApplyername.contains(searchApplyername)) {
        return true;
      }
      return false;
    }).toList();
  }

  void _reset() {
    _keyword = null;
    page = 1;
    _applys.clear();
    _applysAfterFilter.clear();
    _startPoint = '';
    _endPoint = '';
  }

  @override
  Future<void> init(String status) async {
    _reset();
    final paginationProducts = await _iApplyService.getApplys(
      page: 1,
      pageSize: 10,
      bookingId: _isMyApplys ? null : _bookingDto!.id,
      sortUpdatedAt: -1,
    );
    _applys = paginationProducts ?? [];
    _totalCount = _iApplyService.total;
    filter();
    notifyListeners();
  }

  @override
  Future<void> getMoreApplys(String status) async {
    if (_totalCount == 0) {
      return;
    }
    _isLoading = true;
    notifyListeners();

    final paginationApplys = await _iApplyService.getApplys(
      page: page,
      pageSize: page * 10,
      bookingId: _isMyApplys ? null : _bookingDto!.id,
      sortUpdatedAt: -1,
    );

    _applys.addAll(
      paginationApplys ?? [],
    );
    _totalCount = _iApplyService.total;
    page += 1;
    _isLoading = false;
    filter();
    notifyListeners();
  }

  @override
  Future<void> createApply(CreateApplyDto value) async {
    var result = await _iApplyService.createApply(value);
    if (result != 'Thất bại') {
      await EasyLoading.showSuccess(result);
      Get.offNamed(MyRouter.myApply);
    }
  }

  @override
  Future<void> updateApply(String id, UpdateApplyDto value) async {
    var result = await _iApplyService.updateApply(id, value);
    if (result != 'Thất bại') {
      await EasyLoading.showSuccess(result);
    }
  }
}
