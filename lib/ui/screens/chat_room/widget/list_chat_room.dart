import 'package:flutter/material.dart';
import 'package:twg/core/dtos/chat_room/chat_room_dto.dart';
import 'package:twg/ui/screens/chat_room/widget/list_chat_room_item.dart';

class ListChatRoom extends StatelessWidget {
  final List<ChatRoomDto> ChatRooms;
  const ListChatRoom({
    Key? key,
    required this.ChatRooms,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (ctx, index) {
        return ListChatRoomItem(
          ChatRoom: ChatRooms[index],
        );
      },
      itemCount: ChatRooms.length,
    );
  }
}
