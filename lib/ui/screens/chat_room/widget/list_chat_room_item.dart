// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:twg/constants.dart';
import 'package:twg/core/dtos/chat_room/chat_room_dto.dart';
import 'package:twg/core/utils/color_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_custom_cards/flutter_custom_cards.dart';
import 'package:twg/core/view_models/interfaces/imessage_viewmodel.dart';
import 'package:twg/global/global_data.dart';
import 'package:twg/global/locator.dart';
import 'package:twg/global/router.dart';
import 'package:twg/ui/utils/handling_string_utils.dart';
import 'package:lottie/lottie.dart' as lottie;

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
    // String result = "pass";
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
    final partner = (locator<GlobalData>().currentUser?.email.toString() ==
            widget.ChatRoom.user1?.email.toString())
        ? widget.ChatRoom.user2
        : widget.ChatRoom.user1;
    String customStartTime = (widget.ChatRoom.lastMessage != null)
        ? DateTime.parse(widget.ChatRoom.lastMessage!.createdAt as String)
            .toLocal()
            .toString()
            .substring(11, 16)
        : '';

    String messageContent = (widget.ChatRoom.lastMessage != null)
        ? widget.ChatRoom.lastMessage!.message.toString()
        : 'Hai bạn đã được kết nối';
    messageContent = HandlingStringUtils.handleLength(messageContent);

    String unwatch = locator<GlobalData>().currentUser?.email.toString() ==
            widget.ChatRoom.user1!.email.toString()
        ? widget.ChatRoom.numUnwatched1.toString()
        : widget.ChatRoom.numUnwatched2.toString();

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 10.h,
        horizontal: 15.w,
      ),
      child: InkWell(
        onTap: () {
          _iMessageViewModel.setCurrentChatRoom(widget.ChatRoom);
          Get.offNamed(MyRouter.message);
        },
        child: Container(
          decoration: BoxDecoration(
            color: ColorUtils.primaryColor
                .withOpacity(unwatch != '0' ? 0.2 : 0.058),
            borderRadius: BorderRadius.circular(
              15.r,
            ),
          ),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: EdgeInsets.all(
                    10.r,
                  ),
                  child: Text(
                    customStartTime,
                  ),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      partner!.avatarUrl == avatarUrl
                          ? Lottie.asset(
                              'assets/lottie/avatar.json',
                              fit: BoxFit.fill,
                              height: 90.h,
                              width: 80.w,
                            )
                          : Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 10.h,
                                horizontal: 10.w,
                              ),
                              child: CachedNetworkImage(
                                imageUrl: partner.avatarUrl as String,
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(
                                        60.0,
                                      ),
                                    ),
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                placeholder: (context, url) => SizedBox(
                                  width: 50.w,
                                  height: 50.w,
                                  child: lottie.Lottie.asset(
                                    "assets/lottie/loading_image.json",
                                    repeat: true,
                                  ),
                                ),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            ),
                      SizedBox(
                        width: 10.w,
                      ),
                      SizedBox(
                        width: 250.w,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              partner.firstName as String,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              height: 8.h,
                            ),
                            Text(
                              messageContent,
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  if (unwatch != '0')
                    Padding(
                      padding: EdgeInsets.all(
                        10.r,
                      ),
                      child: CustomCard(
                        width: 26.w,
                        height: 26.h,
                        color: ColorUtils.primaryColor,
                        borderRadius: 12,
                        child: Center(
                          child: Text(
                            unwatch,
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
