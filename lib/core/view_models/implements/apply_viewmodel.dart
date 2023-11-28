import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:twg/core/dtos/apply/apply_dto.dart';
import 'package:twg/core/dtos/apply/create_apply_dto.dart';
import 'package:twg/core/dtos/apply/update_apply_dto.dart';
import 'package:twg/core/dtos/booking/booking_dto.dart';
import 'package:twg/core/services/interfaces/iapply_service.dart';
import 'package:twg/core/view_models/interfaces/iapply_viewmodel.dart';
import 'package:twg/global/locator.dart';
import 'package:twg/global/router.dart';

class ApplyViewModel with ChangeNotifier implements IApplyViewModel {
  List<ApplyDto> _applys = [];
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
  void _reset() {
    _keyword = null;
    page = 1;
    _applys.clear();
  }

  @override
  Future<void> init(String status) async {
    _reset();
    final paginationProducts = await _iApplyService.getApplys(
      page: 1,
      pageSize: 10,
    );
    _applys = paginationProducts ?? [];
    _totalCount = _iApplyService.total;
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
    );

    _applys.addAll(
      paginationApplys ?? [],
    );
    _totalCount = _iApplyService.total;
    page += 1;
    _isLoading = false;
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
