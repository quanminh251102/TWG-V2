import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:twg/core/services/interfaces/iauth_service.dart';
import 'package:twg/core/services/interfaces/isocket_service.dart';
import 'package:twg/core/utils/token_utils.dart';
import 'package:twg/global/global_data.dart';
import 'package:twg/global/locator.dart';

import '../../../../global/router.dart';
import '../interfaces/isplash_screen_view_model.dart';

class SplashScreenViewModel extends ChangeNotifier
    implements ISplashScreenViewModel {
  final IAuthService _iAuthService = locator<IAuthService>();
  final ISocketService _iSocketService = locator<ISocketService>();
  @override
  Future<void> goToNextPage() async {
    var logined = await _iAuthService.checkLogin();
    if (logined) {
      var token = await TokenUtils.getToken();
      _iSocketService.connectServer(token as String);
      Get.offNamed(
        MyRouter.booking,
      );
    } else {
      Get.offNamed(
        MyRouter.onBoarding,
      );
    }
  }
}
