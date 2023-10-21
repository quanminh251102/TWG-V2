import 'package:flutter/material.dart';
import 'package:twg/core/dtos/message/message_dto.dart';

abstract class IMessageViewModel implements ChangeNotifier {
  List<MessageDto> get Messages;
  bool get isLoading;
  String? get keyword;
  Future<void> init(String status);
  Future<void> getMoreMessages(String status);
}
