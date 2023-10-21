import 'package:twg/core/dtos/auth/access_token_dto.dart';
import 'package:twg/core/dtos/auth/account_dto.dart';
import 'package:twg/core/dtos/auth/login_dto.dart';
import 'package:twg/core/dtos/base_api_dto.dart';
import 'package:twg/core/utils/token_utils.dart';
import 'package:twg/global/global_data.dart';
import 'package:twg/global/locator.dart';

import '../../../ui/utils/loading_dialog_utils.dart';

import '../interfaces/iauth_service.dart';

class AuthService implements IAuthService {
  @override
  Future<AccountDto?> login(String emailOrPhone, String password) async {
    AccountDto? account;
    BaseApiDto<AccountDto> profileResponseDto;
    LoadingDialogUtils.showLoading();
    try {
      var result = await getRestClient()
          .getToken(LoginDto(email: emailOrPhone, password: password));
      if (result.success) {
        TokenUtils.saveToken(result.data!.accsess_token ?? "");
      }
      var token = await TokenUtils.getToken();
      if (token != null) {
        LoadingDialogUtils.showLoading();
        try {
          profileResponseDto = await getRestClient().getProfile(token: token);
          account = profileResponseDto.data;
          locator<GlobalData>().currentUser = account;
          return account;
        } on Exception catch (e) {
          print(e);
        } finally {
          LoadingDialogUtils.hideLoading();
        }
      }
    } on Exception catch (e) {
      print(e);
    } finally {
      LoadingDialogUtils.hideLoading();
    }
    return null;
  }

  @override
  Future<bool> checkLogin() async {
    var token = await TokenUtils.getToken();
    if (token != null) {
      LoadingDialogUtils.showLoading();
      try {
        var result = await getRestClient().getProfile(token: token);
        if (result.success) {
          TokenUtils.saveToken(token);
          locator<GlobalData>().currentUser = result.data;
          return true;
        }
      } catch (e) {
        print(e);
      } finally {
        LoadingDialogUtils.hideLoading();
      }
    }
    return false;
  }
}
