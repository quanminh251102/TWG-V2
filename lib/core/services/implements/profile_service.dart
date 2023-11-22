import 'package:twg/core/dtos/auth/account_dto.dart';
import 'package:twg/core/services/interfaces/iprofile_service.dart';
import 'package:twg/core/utils/token_utils.dart';
import 'package:twg/global/locator.dart';

class ProfileService implements IProfileService {
  @override
  Future<AccountDto?> updateProfile(
    AccountDto accountDto,
  ) async {
    String? token = await TokenUtils.getToken();
    try {
      var result =
          await getRestClient().updateProfile(token.toString(), accountDto);

      if (result.success) {
        return result.data;
      }
    } on Exception catch (e) {
      print(e);
    }
    return null;
  }

  @override
  Future<AccountDto?> getProfile() async {
    String? token = await TokenUtils.getToken();
    try {
      var result = await getRestClient().getProfile(token: token.toString());

      if (result.success) {
        return result.data;
      }
    } on Exception catch (e) {
      print(e);
    }
    return null;
  }
}
