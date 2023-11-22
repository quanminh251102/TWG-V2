import 'package:flutter/material.dart';
import 'package:twg/core/dtos/auth/account_dto.dart';
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
}
