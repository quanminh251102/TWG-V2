import 'package:flutter/material.dart';
import 'package:twg/core/dtos/apply/apply_dto.dart';
import 'package:twg/core/dtos/apply/create_apply_dto.dart';
import 'package:twg/core/dtos/apply/update_apply_dto.dart';
import 'package:twg/core/dtos/booking/booking_dto.dart';

abstract class IApplyViewModel implements ChangeNotifier {
  List<ApplyDto> get applys;
  bool get isLoading;
  String? get keyword;
  BookingDto? get bookingDto;
  void setBookingDto(BookingDto value);
  Future<void> init(String status);
  Future<void> getMoreApplys(String status);
  Future<String> createApply(CreateApplyDto value);
  Future<String> updateApply(String id, UpdateApplyDto value);
}
