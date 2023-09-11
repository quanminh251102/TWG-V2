import 'package:twg/core/dtos/auth/account_dto.dart';

abstract class IAuthService {
  Future<void> login(String emailOrPhone, String password);
}
