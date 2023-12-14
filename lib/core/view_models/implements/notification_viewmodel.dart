import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:twg/core/dtos/chat_room/chat_room_dto.dart';
import 'package:twg/core/dtos/notification/notification_dto.dart';
import 'package:twg/core/services/interfaces/inotification_service.dart';
import 'package:twg/core/services/interfaces/isocket_service.dart';
import 'package:twg/core/view_models/interfaces/inotification_viewmodal.dart';
import 'package:twg/global/locator.dart';
import 'package:twg/ui/utils/notification_utils.dart';
import 'package:windows_notification/notification_message.dart';
import 'package:windows_notification/windows_notification.dart';

final _winNotifyPlugin = WindowsNotification(
    applicationId:
        "r{D65231B0-B2F1-4857-A4CE-A8E7C6EA7D27}\WindowsPowerShell\v1.0\powershell.exe");

class NotificationViewModel
    with ChangeNotifier
    implements INotificationViewModel {
  ChatRoomDto _currentChatRoom = ChatRoomDto();
  List<NotificationDto> _notifications = [];
  int _totalCount = 0;
  bool _isLoading = false;
  int page = 1;

  String? _keyword;

  final INotificationService _iNotificationService =
      locator<INotificationService>();
  final ISocketService _iSocketService = locator<ISocketService>();

  final ScrollController _scrollController = ScrollController();

  @override
  List<NotificationDto> get notifications => _notifications;
  @override
  String? get keyword => _keyword;
  @override
  bool get isLoading => _isLoading;

  int _numUnWatched = 0;
  @override
  int get numUnWatched => _numUnWatched;

  @override
  void initSocketEventForNotification() {
    _iSocketService.socket!.on("receive_notification", (jsonData) async {
      final jsonValue = json.encode(jsonData);
      final data = json.decode(jsonValue) as Map<String, dynamic>;
      _numUnWatched++;
      notifyListeners();

      if (Platform.isWindows) {
        // create new NotificationMessage instance with id, title, body, and images
        NotificationMessage message = NotificationMessage.fromPluginTemplate(
          "test1",
          "Thông báo",
          data["notification_body"],
        );

// show notification
        _winNotifyPlugin.showNotificationPluginTemplate(message);
      } else {
        NotifiationUtils().showNotification(
          title: "Thông báo",
          body: data["notification_body"],
        );
      }
    });

    print('init socket chat room');
  }

  void _reset() {
    _keyword = null;
    page = 1;
    _notifications.clear();
  }

  @override
  Future<void> init(String status) async {
    _reset();
    _numUnWatched = 0;
    final paginationProducts = await _iNotificationService.getNotifications(
      page: 1,
      pageSize: 100,
    );
    _notifications = paginationProducts ?? [];
    _totalCount = _iNotificationService.total;
    notifyListeners();
  }

  @override
  Future<void> getMoreMessages(String status) async {
    if (_totalCount == 0) {
      return;
    }
    _isLoading = true;
    notifyListeners();

    final paginationMessages = await _iNotificationService.getNotifications(
      page: page,
      pageSize: page * 10,
    );

    _notifications.addAll(
      paginationMessages ?? [],
    );
    _totalCount = _iNotificationService.total;
    page += 1;
    _isLoading = false;
    notifyListeners();
  }
}
