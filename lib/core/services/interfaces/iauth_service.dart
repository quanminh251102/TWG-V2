import 'package:twg/core/dtos/auth/account_dto.dart';

abstract class IAuthService {
  Future<AccountDto?> login(String emailOrPhone, String password);
  Future<bool> checkLogin();
}
