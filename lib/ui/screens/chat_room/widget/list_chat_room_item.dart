// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import 'package:twg/core/dtos/chat_room/chat_room_dto.dart';
import 'package:twg/core/utils/color_utils.dart';

class ListChatRoomItem extends StatefulWidget {
  final ChatRoomDto ChatRoom;
  const ListChatRoomItem({
    Key? key,
    required this.ChatRoom,
  }) : super(key: key);

  @override
  State<ListChatRoomItem> createState() => _ListChatRoomItemState();
}

class _ListChatRoomItemState extends State<ListChatRoomItem> {
  bool isNavigateChatRoom = false;
  bool isNavigateCreateApply = false;

  void navigateChatRoom(BuildContext context) async {
    setState(() {
      isNavigateChatRoom = true;
    });
    // Rawait Future.delayed(Duration(seconds: 2));
    String result = "pass";
    // ChatRoom chatRoom = ChatRoom(
    //     id: '',
    //     partner_name: '',
    //     partner_gmail: '',
    //     partner_avatar: '',
    //     partner_id: '',
    //     numUnWatch: 0,
    //     lastMessage: {});
    // try {
    //   await ChatRoomService.getChatRoomInChatRoom(widget.ChatRoom.authorId)
    //       .then((value) {
    //     chatRoom = value;
    //   });
    // } catch (e) {
    //   result = "error";
    // }
    // if (result == "pass") {
    //   BlocProvider.of<MessageCubit>(context).setChatRoom(chatRoom);
    //   BlocProvider.of<MessageCubit>(context).get_message();
    //   BlocProvider.of<MessageCubit>(context).join_chat_room();
    //   appRouter.push(const ChatPageRoute());
    // }
    // setState(() {
    //   isNavigateChatRoom = false;
    // });
  }

  void navigateCreateApply(BuildContext context) async {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //       builder: (context) => CreateApplyPage(ChatRoom: widget.ChatRoom)),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
      child: Card(
        elevation: 3,
        shadowColor: Colors.grey,
        child: Container(
          color: Colors.white.withOpacity(0.85),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
            child: Column(
              children: [
                Text(widget.ChatRoom.user1!.email as String),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
