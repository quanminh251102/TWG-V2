import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:twg/core/dtos/auth/account_dto.dart';

abstract class IProfileViewModel implements ChangeNotifier {
  AccountDto get accountDto;
  Future<void> getProfile();
  Future<String> updateProfile(AccountDto accountDto);
  Future<String> uploadFile(XFile file);
}
