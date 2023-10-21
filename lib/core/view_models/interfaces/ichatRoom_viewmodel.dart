import 'package:flutter/material.dart';
import 'package:twg/core/dtos/chat_room/chat_room_dto.dart';

abstract class IChatRoomViewModel implements ChangeNotifier {
  List<ChatRoomDto> get ChatRooms;
  bool get isLoading;
  String? get keyword;
  Future<void> init(String status);
  Future<void> getMoreChatRooms(String status);
}
