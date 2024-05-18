import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:twg/core/dtos/notification/notification_dto.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:lottie/lottie.dart' as lottie;

class ListNotificationItem extends StatefulWidget {
  final NotificationDto notification;
  const ListNotificationItem({
    Key? key,
    required this.notification,
  }) : super(key: key);

  @override
  State<ListNotificationItem> createState() => _ListNotificationItemState();
}

class _ListNotificationItemState extends State<ListNotificationItem> {
  @override
  Widget build(BuildContext context) {
    String customStartTime =
        DateTime.parse(widget.notification.createdAt as String)
            .toLocal()
            .toString()
            .substring(11, 16);

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 10.h,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CachedNetworkImage(
            imageUrl: widget.notification.author!.avatarUrl as String,
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
            placeholder: (context, url) => SizedBox(
              width: 50.w,
              height: 50.w,
              child: lottie.Lottie.asset(
                "assets/lottie/loading_image.json",
                repeat: true,
              ),
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          const SizedBox(width: 24),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  overflow: TextOverflow.clip,
                  textAlign: TextAlign.end,
                  textDirection: TextDirection.rtl,
                  softWrap: true,
                  text: TextSpan(
                    style: DefaultTextStyle.of(context).style,
                    children: <TextSpan>[
                      TextSpan(
                        text: widget.notification.author!.firstName as String,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      const TextSpan(text: ' '),
                      TextSpan(
                        text: widget.notification.text,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  customStartTime,
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
