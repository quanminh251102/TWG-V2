import 'package:dialog_flowtter/dialog_flowtter.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter/material.dart';

abstract class IChatbotViewModel implements ChangeNotifier {
  List<Map<String, dynamic>> get message;
  List<types.Message> get responseMessages;
  Future<void> initConversation();
  Future<void> sendMessage(String text);
  void addMessage(Message message, [bool isUserMessage = false]);
}
