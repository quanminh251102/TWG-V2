import 'package:twg/core/dtos/auth/account_dto.dart';

abstract class IProfileService {
  Future<AccountDto?> updateProfile(AccountDto accountDto);
  Future<AccountDto?> getProfile();
}
