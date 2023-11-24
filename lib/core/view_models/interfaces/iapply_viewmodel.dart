import 'package:flutter/material.dart';
import 'package:twg/core/dtos/apply/apply_dto.dart';

abstract class IApplyViewModel implements ChangeNotifier {
  List<ApplyDto> get applys;
  bool get isLoading;
  String? get keyword;
  Future<void> init(String status);
  Future<void> getMoreApplys(String status);
}
