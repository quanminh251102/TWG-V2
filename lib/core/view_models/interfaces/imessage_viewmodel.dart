import 'package:flutter/material.dart';
import 'package:twg/core/dtos/auth/account_dto.dart';
import 'package:twg/core/dtos/chat_room/chat_room_dto.dart';
import 'package:twg/core/dtos/message/message_dto.dart';
import 'package:twg/core/dtos/message/send_message_dto.dart';

abstract class IMessageViewModel implements ChangeNotifier {
  List<MessageDto> get Messages;
  bool get isLoading;
  String? get keyword;
  Future<void> init(String status);
  Future<void> getMoreMessages(String status);
  void removeMessageEvent();
  void setCurrentChatRoom(ChatRoomDto chatRoomDto);
  void sendMessage(String message);
  late ScrollController scrollController;
  void jumbToLastMessage();
  AccountDto? getPartner();
}
