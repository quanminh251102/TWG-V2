import 'dart:math';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dialog_flowtter/dialog_flowtter.dart';
import 'package:flutter/material.dart';
import 'package:twg/core/view_models/interfaces/ichatbot_viewmodel.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class ChatbotViewModel with ChangeNotifier implements IChatbotViewModel {
  late DialogFlowtter _dialogFlowtter;
  final List<Map<String, dynamic>> _messages = [];

  final List<types.Message> _responseMessages = [];
  @override
  List<types.Message> get responseMessages => _responseMessages;

  @override
  List<Map<String, dynamic>> get message => _messages;
  String generateRandomId() {
    Random random = Random();
    int randomNumber = random.nextInt(90000000) + 10000000;
    String randomId = randomNumber.toString();
    return randomId;
  }

  @override
  Future<void> initConversation() async {
    _responseMessages.clear();
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
      if (response.message == null) return;
      addMessage(response.message!);
    }
    notifyListeners();
  }

  @override
  void addMessage(Message message, [bool isUserMessage = false]) {
    _responseMessages.add(types.TextMessage(
      author: types.User(
        id: isUserMessage ? 'User' : 'Bot',
      ),
      createdAt: DateTime.parse(DateTime.now().toIso8601String())
          .millisecondsSinceEpoch,
      id: generateRandomId(),
      text: message.text?.text?[0] as String,
    ));
    notifyListeners();
  }
}
