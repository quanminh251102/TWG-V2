import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:twg/core/dtos/call/call_info_dto.dart';

abstract class ICallViewModel implements ChangeNotifier {
  CallInfoDto get callInfo;
  IO.Socket? get socket;
  void initSocketEventForCall();
  void setSocket(IO.Socket value);
  void makeCall(CallInfoDto info);
}
