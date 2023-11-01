import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:twg/core/dtos/chat_room/chat_room_dto.dart';
import 'package:twg/core/services/interfaces/ichat_room_service.dart';
import 'package:twg/core/services/interfaces/isocket_service.dart';
import 'package:twg/core/view_models/interfaces/ichat_room_viewmodel.dart';
import 'package:twg/global/locator.dart';
import 'package:twg/ui/utils/notification_utils.dart';

class ChatRoomViewModel with ChangeNotifier implements IChatRoomViewModel {
  List<ChatRoomDto> _ChatRooms = [];
  int _totalCount = 0;
  bool _isLoading = false;
  int page = 1;
  String? _keyword;

  final IChatRoomService _iChatRoomService = locator<IChatRoomService>();
  final ISocketService _iSocketService = locator<ISocketService>();

  @override
  List<ChatRoomDto> get ChatRooms => _ChatRooms;
  @override
  String? get keyword => _keyword;
  @override
  bool get isLoading => _isLoading;
  void _reset() {
    _keyword = null;
    page = 1;
    _ChatRooms.clear();
  }

  @override
  void initSocketEventForChatRoom() {
    _iSocketService.socket!.on("reload_chat_room", (jsonData) async {
      final paginationProducts = await _iChatRoomService.getChatRooms(
        page: 1,
        pageSize: 10,
      );
      _ChatRooms = paginationProducts ?? [];
      _totalCount = _iChatRoomService.total;
      notifyListeners();
    });

    _iSocketService.socket!.on("receive_notification", (jsonData) async {
      final jsonValue = json.encode(jsonData);
      final data = json.decode(jsonValue) as Map<String, dynamic>;
      NotifiationUtils().showNotification(
        title: "Thông báo",
        body: data["notification_body"],
      );
    });
  }

  @override
  Future<void> init(String status) async {
    _reset();
    final paginationProducts = await _iChatRoomService.getChatRooms(
      page: 1,
      pageSize: 10,
    );
    _ChatRooms = paginationProducts ?? [];
    _totalCount = _iChatRoomService.total;
    notifyListeners();
  }

  @override
  Future<void> getMoreChatRooms(String status) async {
    if (_totalCount == 0) {
      return;
    }
    _isLoading = true;
    notifyListeners();

    final paginationChatRooms = await _iChatRoomService.getChatRooms(
      page: page,
      pageSize: page * 10,
    );

    _ChatRooms.addAll(
      paginationChatRooms ?? [],
    );
    _totalCount = _iChatRoomService.total;
    page += 1;
    _isLoading = false;
    notifyListeners();
  }
}
