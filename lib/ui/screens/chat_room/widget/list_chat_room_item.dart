// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:twg/core/dtos/chat_room/chat_room_dto.dart';
import 'package:twg/core/utils/color_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_custom_cards/flutter_custom_cards.dart';
import 'package:twg/core/view_models/interfaces/imessage_viewmodel.dart';
import 'package:twg/global/router.dart';

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
  late IMessageViewModel _iMessageViewModel;
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
  void initState() {
    _iMessageViewModel = context.read<IMessageViewModel>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      elevation: 0,
      height: 80,
      childPadding: 8,
      onTap: () {
        _iMessageViewModel.setCurrentChatRoom(widget.ChatRoom);
        Get.offNamed(MyRouter.message);
      },
      borderRadius: 12,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CachedNetworkImage(
            imageUrl: widget.ChatRoom.user1!.avatarUrl as String,
            imageBuilder: (context, imageProvider) => Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(
                        60.0) //                 <--- border radius here
                    ),
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
          SizedBox(width: 12),
          SizedBox(
            width: 200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(height: 8),
                Text(
                  widget.ChatRoom.user1!.email as String,
                  style: TextStyle(fontSize: 16),
                ),
                Text('Tin nhắn')
              ],
            ),
          ),
          Expanded(child: SizedBox()),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (widget.ChatRoom.numUnwatched1 as int > 0)
                CustomCard(
                  width: 26,
                  height: 26,
                  child: Center(
                    child: Text(
                      (widget.ChatRoom.numUnwatched1 as int).toString(),
                    ),
                  ),
                  color: ColorUtils.primaryColor,
                  borderRadius: 12,
                ),
              if (widget.ChatRoom.numUnwatched1 == 0)
                SizedBox(
                  width: 26,
                  height: 26,
                ),
              // Text(handeDateString_getTime(
              //     chatRoom.lastMessage["createdAt"]))
            ],
          ),
        ],
      ),
    );
  }
}
