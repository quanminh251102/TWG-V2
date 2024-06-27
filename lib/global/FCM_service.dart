import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'notification_service.dart';

class FirebaseFCM {
  Future<void> init() async {
    FirebaseFCM().addToken();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      if (message.notification != null) {
        NotificationService().showNotification(
          title: message.notification!.title,
          body: message.notification!.body,
          payLoad: 'notification',
        );
      }
    });
  }

  Future<void> addToken() async {
    try {
      FirebaseMessaging messaging = FirebaseMessaging.instance;
      final token = await messaging.getToken() ?? "null";
      await Dio().post("$baseUrl/const-value/addToken", data: {"token": token});
      log("ok");
    } catch (e) {
      print(e);
    }
  }
}
