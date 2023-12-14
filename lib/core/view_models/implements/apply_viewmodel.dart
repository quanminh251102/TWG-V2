import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:twg/core/dtos/apply/apply_dto.dart';
import 'package:twg/core/dtos/apply/create_apply_dto.dart';
import 'package:twg/core/dtos/apply/update_apply_dto.dart';
import 'package:twg/core/dtos/booking/booking_dto.dart';
import 'package:twg/core/services/interfaces/iapply_service.dart';
import 'package:twg/core/services/interfaces/isocket_service.dart';
import 'package:twg/core/view_models/interfaces/iapply_viewmodel.dart';
import 'package:twg/global/locator.dart';
import 'package:twg/global/router.dart';
import 'package:twg/ui/common_widgets/coming_apply_dialog.dart';

class ApplyViewModel with ChangeNotifier implements IApplyViewModel {
  List<ApplyDto> _applys = [];

  List<ApplyDto> _applysAfterFilter = [];
  @override
  List<ApplyDto> get applysAfterFilter => _applysAfterFilter;
  String _startPoint = '';

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
      init('');
      print('reload_apply');
    });

    _iSocketService.socket!.on("receive_apply", (jsonData) async {
      print('receive_apply');
      final jsonValue = json.encode(jsonData);
      final data = json.decode(jsonValue) as Map<String, dynamic>;
      var value = ApplyDto.fromJson(data);
      Get.dialog(ComingApplyDialog(
        apply: value,
        setBooking: setBookingDto,
      ));
    });
  }

  void filter() {
    _applysAfterFilter = applys.where((apply) {
      String booking_startPoint =
          apply.booking!.startPointMainText.toString().toLowerCase() +
              apply.booking!.startPointAddress.toString().toLowerCase();
      String booking_endPoint =
          apply.booking!.endPointMainText.toString().toLowerCase() +
              apply.booking!.endPointAddress.toString().toLowerCase();
      String search_startPoint = _startPoint.toLowerCase();
      String search_endPoint = _endPoint.toLowerCase();

      String apply_applyerName =
          apply.applyer!.firstName.toString().toLowerCase();
      String search_applyerName = _applyerName.toString().toLowerCase();

      if (booking_startPoint.contains(search_startPoint) &&
          booking_endPoint.contains(search_endPoint) &&
          apply_applyerName.contains(search_applyerName)) {
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
