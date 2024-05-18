import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:twg/core/dtos/auth/account_dto.dart';
import 'package:twg/core/dtos/call/call_info_dto.dart';
import 'package:twg/core/dtos/chat_room/chat_room_dto.dart';
import 'package:twg/core/dtos/message/message_dto.dart';
import 'package:twg/core/dtos/message/send_message_dto.dart';
import 'package:twg/core/services/interfaces/imessage_service.dart';
import 'package:twg/core/services/interfaces/isocket_service.dart';
import 'package:twg/core/view_models/interfaces/imessage_viewmodel.dart';
import 'package:twg/global/global_data.dart';
import 'package:twg/global/locator.dart';

class MessageViewModel with ChangeNotifier implements IMessageViewModel {
  ChatRoomDto _currentChatRoom = ChatRoomDto();
  List<MessageDto> _Messages = [];
  int _totalCount = 0;
  bool _isLoading = false;
  int page = 1;
  String? _keyword;

  final IMessageService _iMessageService = locator<IMessageService>();
  final ISocketService _iSocketService = locator<ISocketService>();

  final ScrollController _scrollController = ScrollController();

  @override
  List<MessageDto> get Messages => _Messages;
  @override
  String? get keyword => _keyword;
  @override
  bool get isLoading => _isLoading;

  @override
  ScrollController get scrollController => _scrollController;

  @override
  void jumbToLastMessage() {
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    }
  }

  void _addMessageEvent() {
    Map data = {
      "chat_room_id": _currentChatRoom.id,
    };
    _iSocketService.socket!.emit("join_chat_room", data);
    _iSocketService.socket!.on("receive_message", (jsonData) {
      print('receive_message');
      final jsonValue = json.encode(jsonData);
      final data = json.decode(jsonValue) as Map<String, dynamic>;
      _Messages.add(MessageDto.fromJson(data));
      jumbToLastMessage();
      notifyListeners();
    });
  }

  @override
  void setCurrentChatRoom(ChatRoomDto chatRoomDto) async {
    _currentChatRoom = chatRoomDto;
  }

  @override
  AccountDto? getPartner() {
    return (locator<GlobalData>().currentUser?.email.toString() ==
            _currentChatRoom.user1!.email.toString())
        ? _currentChatRoom.user2
        : _currentChatRoom.user1;
  }

  @override
  CallInfoDto? getCallInfo() {
    AccountDto me, partner;
    if (locator<GlobalData>().currentUser?.email.toString() ==
        _currentChatRoom.user1!.email.toString()) {
      me = _currentChatRoom.user1 as AccountDto;
      partner = _currentChatRoom.user2 as AccountDto;
    } else {
      me = _currentChatRoom.user2 as AccountDto;
      partner = _currentChatRoom.user1 as AccountDto;
    }

    return CallInfoDto(
      callerId: me.email,
      callerName: me.firstName,
      receiverId: partner.email,
      receiverName: partner.firstName,
      receiverAvatar: partner.avatarUrl,
      callerAvatar: me.avatarUrl,
    );
  }

  @override
  void sendMessage(String message) async {
    _iMessageService.sendMessage(
      value: SendMessageDto(
        message: message,
        chatRoomId: _currentChatRoom.id,
        type: 'text',
      ),
    );
  }

  @override
  void removeMessageEvent() async {
    Map data = {
      "chat_room_id": _currentChatRoom.id,
    };
    _iSocketService.socket!.emit("leave_chat_room", data);
    _iSocketService.socket!.off("receive_message");
  }

  void _reset() {
    _keyword = null;
    page = 1;
    _Messages.clear();
  }

  @override
  Future<void> init(String status) async {
    _reset();
    _addMessageEvent();
    final paginationProducts = await _iMessageService.getMessages(
      page: 1,
      pageSize: 100,
      chatRoomId: _currentChatRoom.id,
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
      chatRoomId: _currentChatRoom.id,
    );

    _Messages.addAll(
      paginationMessages ?? [],
    );
    _totalCount = _iMessageService.total;
    page += 1;
    _isLoading = false;
    notifyListeners();
  }

  @override
  set scrollController(ScrollController scrollController) {
    // TODO: implement scrollController
  }
}
