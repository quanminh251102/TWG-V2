import 'package:flutter/material.dart';
import 'package:twg/core/dtos/notification/notification_dto.dart';
import 'package:twg/ui/screens/notification/widget/list_notification_item.dart';

class ListNotification extends StatelessWidget {
  final List<NotificationDto> notifications;
  const ListNotification({
    Key? key,
    required this.notifications,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (ctx, index) {
        return ListNotificationItem(
          notification: notifications[index],
        );
      },
      itemCount: notifications.length,
    );
  }
}
