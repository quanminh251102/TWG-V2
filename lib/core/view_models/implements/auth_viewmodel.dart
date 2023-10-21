import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:twg/core/services/interfaces/iauth_service.dart';
import 'package:twg/core/services/interfaces/isocket_service.dart';
import 'package:twg/core/utils/token_utils.dart';
import 'package:twg/core/view_models/interfaces/iauth_viewmodel.dart';
import 'package:twg/global/locator.dart';
import 'package:twg/global/router.dart';

class AuthViewModel with ChangeNotifier implements IAuthViewModel {
  final IAuthService _iAuthService = locator<IAuthService>();
  final ISocketService _iSocketService = locator<ISocketService>();
  @override
  Future<void> login(String phone, String password) async {
    var account = await _iAuthService.login(phone, password);

    if (account != null) {
      var token = await TokenUtils.getToken();
      _iSocketService.connectServer(token.toString());
      await EasyLoading.showSuccess('Đăng nhập thành công!');
      Get.offNamed(MyRouter.booking);
    } else {
      await EasyLoading.showError('Đăng nhập thất bại!');
    }
  }

  @override
  Future<void> logout() async {
    // _iAuthService.logOut();
    // _profile = null;
    // locator<GlobalData>().currentUser = null;
    // _provinces.clear();
  }

  // @override
  // Future<void> init() async {
  //   var logined = await _iAuthService.checkLogin();

  //   if (logined) {
  //     Get.offNamed(MyRouter.home);
  //   } else {
  //     Get.offNamed(MyRouter.login);
  //   }
  // }

  // @override
  // Future<void> changePassword(
  //     String currentPassword, String newPassword) async {
  //   bool result =
  //       await _iAuthService.changePassword(currentPassword, newPassword);
  //   if (result) {
  //     EasyLoading.showSuccess("Đổi mật khẩu thành công!");
  //     await _iAuthService.logOut();
  //     Get.offNamed(MyRouter.login);
  //   } else {
  //     EasyLoading.showError("Đổi mật khẩu thất bại!");
  //   }
  // }

  // @override
  // Future<void> updateAvatar(UploadFileDto file) async {
  //   var upload = await _iAuthService.updateAvatar(file);
  //   if (upload) {
  //     getProfile();
  //   }
  // }

  // @override
  // Future<bool> confirmCode(String code, int? userId) async {
  //   var result = await _iAuthService.confirmCode(code, _currentUserId!);
  //   return result;
  // }

  // @override
  // Future<bool> reSendConfirmCode(int typeId) async {
  //   var result = true;
  //   //  await _iAuthService.reSendConfirmCode(_currentUserId!, typeId);
  //   // if (result) {
  //   //   await EasyLoading.showSuccess('Đã gửi lại!');
  //   // }
  //   return result;
  // }

  // @override
  // Future<bool> forgotPassword(String emailOrPhone) async {
  //   var result = await _iAuthService.forgotPassword(emailOrPhone);
  //   if (result != null) {
  //     if (result.success == true) {
  //       _currentUserId = result.result!.userId;
  //       await EasyLoading.showSuccess('Mã xác nhận đã được gửi!');
  //       return true;
  //     }
  //   }
  //   return false;
  // }

  // @override
  // Future<void> resetPassword(String newPassword) async {
  //   var result =
  //       await _iAuthService.resetPassword(_currentUserId!, newPassword);
  //   if (result) {
  //     await EasyLoading.showSuccess('Đổi mật khẩu thành công!');
  //     Get.offNamed(MyRouter.login);
  //   }
  // }

  // @override
  // Future<void> getProfile({bool showLoading = true}) async {
  //   await _iAuthService.getProfile(
  //     showLoading: showLoading,
  //   );
  //   _profile = locator<GlobalData>().currentUser;
  //   notifyListeners();
  // }
}
