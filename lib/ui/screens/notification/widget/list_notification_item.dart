import 'package:flutter/material.dart';
import 'package:twg/core/dtos/notification/notification_dto.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_custom_cards/flutter_custom_cards.dart';

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

    return CustomCard(
      elevation: 0,
      height: 80,
      childPadding: 10,
      onTap: () {},
      borderRadius: 12,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
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
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
              const SizedBox(width: 24),
              SizedBox(
                // width: 200,
                height: 50,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      // Controls visual overflow
                      overflow: TextOverflow.clip,

                      // Controls how the text should be aligned horizontally
                      textAlign: TextAlign.end,

                      // Control the text direction
                      textDirection: TextDirection.rtl,

                      // Whether the text should break at soft line breaks
                      softWrap: true,

                      // Maximum number of lines for the text to span
                      maxLines: 1,

                      // The number of font pixels for each logical pixel
                      textScaleFactor: 1,
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                            text:
                                widget.notification.author!.firstName as String,
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
                    Text(
                      customStartTime,
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
