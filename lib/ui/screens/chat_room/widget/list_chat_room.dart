import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:twg/core/dtos/chat_room/chat_room_dto.dart';
import 'package:twg/ui/screens/chat_room/widget/list_chat_room_item.dart';

class ListChatRoom extends StatelessWidget {
  final List<ChatRoomDto> chatRooms;
  const ListChatRoom({
    Key? key,
    required this.chatRooms,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.only(top: 0.h),
      itemBuilder: (ctx, index) {
        return ListChatRoomItem(
          chatRoom: chatRooms[index],
        );
      },
      itemCount: chatRooms.length,
    );
  }
}
