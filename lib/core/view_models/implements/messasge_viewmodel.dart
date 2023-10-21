import 'package:flutter/material.dart';
import 'package:twg/core/dtos/message/message_dto.dart';
import 'package:twg/core/services/interfaces/imessage_service.dart';
import 'package:twg/core/view_models/interfaces/imessage_viewmodel.dart';
import 'package:twg/global/locator.dart';

class MessageViewModel with ChangeNotifier implements IMessageViewModel {
  List<MessageDto> _Messages = [];
  int _totalCount = 0;
  bool _isLoading = false;
  int page = 1;
  String? _keyword;

  final IMessageService _iMessageService = locator<IMessageService>();
  @override
  List<MessageDto> get Messages => _Messages;
  @override
  String? get keyword => _keyword;
  @override
  bool get isLoading => _isLoading;
  void _reset() {
    _keyword = null;
    page = 1;
    _Messages.clear();
  }

  @override
  Future<void> init(String status) async {
    _reset();
    final paginationProducts = await _iMessageService.getMessages(
      page: 1,
      pageSize: 10,
    );
    _Messages = paginationProducts ?? [];
    _totalCount = _iMessageService.total;
    notifyListeners();
  }

  @override
  Future<void> getMoreMessages(String status) async {
    if (_totalCount == 0) {
      return;
    }
    _isLoading = true;
    notifyListeners();

    final paginationMessages = await _iMessageService.getMessages(
      page: page,
      pageSize: page * 10,
    );

    _Messages.addAll(
      paginationMessages ?? [],
    );
    _totalCount = _iMessageService.total;
    page += 1;
    _isLoading = false;
    notifyListeners();
  }
}
