import 'package:flutter/material.dart';
import 'package:twg/core/dtos/apply/apply_dto.dart' as Model;
import 'package:twg/core/services/interfaces/iapply_service.dart';
import 'package:twg/core/view_models/interfaces/iapply_viewmodel.dart';
import 'package:twg/global/locator.dart';

class ApplyViewModel with ChangeNotifier implements IApplyViewModel {
  List<Model.ApplyDto> _applys = [];
  int _totalCount = 0;
  bool _isLoading = false;
  int page = 1;
  String? _keyword;

  final IApplyService _iApplyService = locator<IApplyService>();
  Model.ApplyDto? _applyDto;

  @override
  Model.ApplyDto? get applyDto => _applyDto;

  @override
  List<Model.ApplyDto> get applys => _applys;
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
}
