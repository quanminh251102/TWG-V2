import 'package:dialog_flowtter/dialog_flowtter.dart';
import 'package:flutter/material.dart';

abstract class IChatbotViewModel implements ChangeNotifier {
  List<Map<String, dynamic>> get message;
  Future<void> initConversation();
  Future<void> sendMessage(String text);
  void addMessage(Message message, [bool isUserMessage = false]);
}
