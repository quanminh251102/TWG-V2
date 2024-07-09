import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:twg/core/dtos/auth/account_dto.dart';
import 'package:twg/core/services/interfaces/iauth_service.dart';
import 'package:twg/core/services/interfaces/icloudinary_service.dart';
import 'package:twg/core/services/interfaces/iprofile_service.dart';
import 'package:twg/core/view_models/interfaces/iprofile_viewmodel.dart';
import 'package:twg/global/locator.dart';

class ProfileViewModel with ChangeNotifier implements IProfileViewModel {
  AccountDto _accountDto = AccountDto(
      firstName: 'Name',
      email: '...@gmail.com',
      avatarUrl:
          "https://res.cloudinary.com/dxoblxypq/image/upload/v1679984586/9843c460ff72ee89d791bffe667e451c_rzalqh.jpg");

  @override
  AccountDto get accountDto => _accountDto;

  final IProfileService _iMessageService = locator<IProfileService>();
  final ICloudinaryService _iCloudinaryService = locator<ICloudinaryService>();
  final IAuthService _iAuthService = locator<IAuthService>();
  @override
  Future<void> getProfile() async {
    var result = await _iMessageService.getProfile();
    if (result != null) {
      _accountDto = result;
      notifyListeners();
    }
  }

  @override
  Future<String> updateProfile(AccountDto accountDto) async {
    var result = await _iMessageService.updateProfile(accountDto);
    if (result != null) {
      _accountDto = result;
      notifyListeners();
      return 'Thành công';
    }
    return 'Thất bại';
  }

  @override
  Future<String> uploadFile(XFile file) async {
    var result = await _iCloudinaryService.uploadFile(file);
    return result;
  }

  @override
  Future<AccountDto?> getUserById(String userId) async {
    var result = await _iAuthService.getUserById(userId);
    return result;
  }
}
