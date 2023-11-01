import 'package:flutter/material.dart';
import 'package:twg/core/dtos/auth/account_dto.dart';

abstract class IAuthViewModel implements ChangeNotifier {
  Future<void> login(String phone, String password);
  Future<void> logout();
  Future<void> signInGoogle();
  // List<ProvinceDto> get provinces;
  // List<ChannelDto> get channels;
  // List<ChannelDto> get listChannel;
  // Future<void> login(String phoneOrEmail, String password);
  // Future<void> getProfile({bool showLoading});
  // Future<bool> confirmCode(String code, int? userId);
  // Future<bool> reSendConfirmCode(int typeId);
  // Future<bool> forgotPassword(String emailOrPhone);
  // Future<void> resetPassword(String newPassword);
  // Future<void> logout();
  // Future<void> init();
  // Future<void> updateAccount(AccountUpdateDto accountUpdateDto);
  // Future<void> changePassword(String currentPassword, String newPassword);
  // Future<void> updateAvatar(UploadFileDto file);
  // Future<void> getChannels();
  // Future<void> getProvinces();
  // Future<void> getListChannel();
  // Future<void> registerAccount(RegisterAccountDto registerAccountDto);
  // Future<void> confirmDeletedAccount(int id);
}
