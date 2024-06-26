import 'package:twg/core/dtos/auth/account_dto.dart';

abstract class IGoogleSignInService {
  Future<AccountDto?> loginGoogle();
}
