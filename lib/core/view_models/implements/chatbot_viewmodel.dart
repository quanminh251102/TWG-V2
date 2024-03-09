import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dialog_flowtter/dialog_flowtter.dart';
import 'package:flutter/material.dart';
import 'package:twg/core/view_models/interfaces/ichatbot_viewmodel.dart';

class ChatbotViewModel with ChangeNotifier implements IChatbotViewModel {
  late DialogFlowtter _dialogFlowtter;
  List<Map<String, dynamic>> _messages = [];

  @override
  List<Map<String, dynamic>> get message => _messages;

  @override
  Future<void> initConversation() async {
   
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    String device =
        '${androidInfo.brand.toUpperCase()} ${androidInfo.model} ${androidInfo.id}';
    _dialogFlowtter = DialogFlowtter(
      sessionId: device,
    );
    notifyListeners();
  }

  @override
  Future<void> sendMessage(String text) async {
    if (text.isEmpty) {
      print('Message is empty');
    } else {
      addMessage(Message(text: DialogText(text: [text])), true);

      DetectIntentResponse response = await _dialogFlowtter.detectIntent(
          queryInput: QueryInput(text: TextInput(text: text)));
      print(response.message);
      if (response.message == null) return;
      addMessage(response.message!);
    }
    notifyListeners();
  }

  @override
  void addMessage(Message message, [bool isUserMessage = false]) {
    _messages.add({'message': message, 'isUserMessage': isUserMessage});
    notifyListeners();
  }
}
