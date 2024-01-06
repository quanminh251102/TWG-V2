import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:twg/core/dtos/call/call_info_dto.dart';
import 'package:twg/core/services/interfaces/isocket_service.dart';
import 'package:twg/core/view_models/interfaces/icall_viewmodel.dart';
import 'package:twg/global/locator.dart';
import 'package:twg/global/router.dart';

class CallViewModel with ChangeNotifier implements ICallViewModel {
  IO.Socket? _socket;
  final CallInfoDto _callInfo = CallInfoDto();

  final ISocketService _iSocketService = locator<ISocketService>();

  @override
  CallInfoDto get callInfo => _callInfo;
  @override
  IO.Socket? get socket => _socket;

  @override
  void setSocket(IO.Socket _value) {
    _socket = _value;
  }

  @override
  void initSocketEventForCall() {
    // when we get a call
    _iSocketService.socket!.on("incoming-call", (data) {
      print("data ${data}");
      print("data from ${data['from']}");

      _callInfo.receiverId = data['from'];
      _callInfo.callerName = data['callerName'];
      _callInfo.callerId = data['callerId'];
      _callInfo.callerAvatar = data['callerAvatar'];
      _callInfo.isCaller = false;
      notifyListeners();
      Get.offNamed(MyRouter.incomingCall);
    });
  }

  @override
  makeCall(CallInfoDto info) {
    print("  <====================> _make call ");

    _callInfo.receiverId = info.receiverId;
    _callInfo.receiverName = info.receiverName;
    _callInfo.callerName = info.callerName;
    _callInfo.callerId = info.callerId;
    _callInfo.callerAvatar = info.callerAvatar;
    _callInfo.receiverAvatar = info.receiverAvatar;
    _callInfo.isCaller = true;
    notifyListeners();

    Get.offNamed(MyRouter.call);
  }
}
