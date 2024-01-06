// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:twg/constants.dart';
import 'package:twg/core/dtos/message/message_dto.dart';
import 'package:twg/core/utils/color_utils.dart';
import 'package:twg/global/global_data.dart';
import 'package:twg/global/locator.dart';

class ListMessageItem extends StatefulWidget {
  final MessageDto Message;
  const ListMessageItem({
    Key? key,
    required this.Message,
  }) : super(key: key);

  @override
  State<ListMessageItem> createState() => _ListMessageItemState();
}

class _ListMessageItemState extends State<ListMessageItem> {
  bool isNavigateMessage = false;
  bool isNavigateCreateApply = false;

  Widget textRight(MessageDto message, String startTime) => Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 24),
        child: Align(
          alignment: Alignment.centerRight,
          child: Container(
            constraints: const BoxConstraints(maxWidth: 250),
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.only(bottom: 5),
            decoration: BoxDecoration(
              color: ColorUtils.primaryColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  constraints: const BoxConstraints(maxWidth: 180),
                  child: Text(
                    message.message as String,
                    style: const TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
                Text(
                  startTime,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
        ),
      );

  Widget textLeft(MessageDto message, String startTime) => Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 24),
        child: Row(
          children: [
            message.userId!.avatarUrl.toString() == avatarUrl
                ? Lottie.asset(
                    'assets/lottie/avatar.json',
                    fit: BoxFit.fill,
                    height: 60.h,
                    width: 60.w,
                  )
                : CachedNetworkImage(
                    imageUrl: message.userId!.avatarUrl.toString(),
                    imageBuilder: (context, imageProvider) => Container(
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
                      child: Lottie.asset(
                        "assets/lottie/loading_image.json",
                        repeat: true,
                      ),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
            Container(
              constraints: const BoxConstraints(maxWidth: 250),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: ColorUtils.primaryColor.withOpacity(0.08),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    constraints: const BoxConstraints(maxWidth: 180),
                    child: Text(
                      message.message as String,
                      style: const TextStyle(fontSize: 15, color: Colors.black),
                    ),
                  ),
                  Text(
                    startTime,
                    style: const TextStyle(color: Colors.grey),
                  )
                ],
              ),
            ),
          ],
        ),
      );

  Widget imageRight(MessageDto message, String startTime) => Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 24),
        child: Align(
          alignment: Alignment.centerRight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // ClipRRect(
              //     borderRadius: BorderRadius.circular(8.0),
              //     child: Image.network(message.message as String,
              //         width: 150, fit: BoxFit.fill)),
              const SizedBox(height: 4),
              Text(startTime, style: TextStyle(color: Colors.grey)),
            ],
          ),
        ),
      );

  Widget imageLeft(MessageDto message, String startTime) => Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 24),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 25,
              backgroundImage:
                  NetworkImage(message.userId!.avatarUrl as String),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // ClipRRect(
                //     borderRadius: BorderRadius.circular(20.0),
                //     child: Image.network(message!.message as String,
                //         width: 150, fit: BoxFit.fill)),
                const SizedBox(height: 4),
                Text(
                  startTime,
                  style: TextStyle(color: Colors.black),
                )
              ],
            ),
          ],
        ),
      );
  // context.watch<MessageCubit>().scrollDown();

  Widget dateWidget(MessageDto message, String startTime) => Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 24),
      child: Center(
          child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color.fromARGB(97, 158, 158, 158),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          message.message as String,
          style: TextStyle(color: Colors.black, fontSize: 12),
        ),
      )));

  void navigateMessage(BuildContext context) async {
    setState(() {
      isNavigateMessage = true;
    });
    // Rawait Future.delayed(Duration(seconds: 2));
    // String result = "pass";
    // Message Message = Message(
    //     id: '',
    //     partner_name: '',
    //     partner_gmail: '',
    //     partner_avatar: '',
    //     partner_id: '',
    //     numUnWatch: 0,
    //     lastMessage: {});
    // try {
    //   await MessageService.getMessageInMessage(widget.Message.authorId)
    //       .then((value) {
    //     Message = value;
    //   });
    // } catch (e) {
    //   result = "error";
    // }
    // if (result == "pass") {
    //   BlocProvider.of<MessageCubit>(context).setMessage(Message);
    //   BlocProvider.of<MessageCubit>(context).get_message();
    //   BlocProvider.of<MessageCubit>(context).join_chat_room();
    //   appRouter.push(const ChatPageRoute());
    // }
    // setState(() {
    //   isNavigateMessage = false;
    // });
  }

  void navigateCreateApply(BuildContext context) async {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //       builder: (context) => CreateApplyPage(Message: widget.Message)),
    // );
  }

  @override
  Widget build(BuildContext context) {
    var _message = widget.Message;
    String customStartTime = DateTime.parse(_message.createdAt as String)
        .toLocal()
        .toString()
        .substring(11, 16);

    String _type = _message.type as String;
    bool isMe = locator<GlobalData>().currentUser?.email.toString() ==
        _message.userId!.email.toString();
    return (_type == "isDate")
        ? dateWidget(_message, customStartTime)
        : isMe // mean is Me
            ? ((_type == "text")
                ? (textRight(_message, customStartTime))
                : (imageRight(_message, customStartTime)))
            : ((_type == "text")
                ? (textLeft(_message, customStartTime))
                : (imageLeft(_message, customStartTime)));
  }
}
