import 'package:flutter/material.dart';

import 'package:twg/core/dtos/notification/notification_dto.dart';

abstract class INotificationViewModel implements ChangeNotifier {
  List<NotificationDto> get notifications;
  bool get isLoading;
  int get numUnWatched;
  Future<void> init(String status);
  Future<void> getMoreMessages(String status);
  void initSocketEventForNotification();
}
