import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:twg/core/dtos/auth/account_dto.dart';
import 'package:twg/core/dtos/auth/login_dto.dart';
import 'package:twg/core/dtos/base_api_dto.dart';
import 'package:twg/core/utils/token_utils.dart';
import 'package:twg/global/global_data.dart';
import 'package:twg/global/locator.dart';
import 'package:twg/global/router.dart';

import '../../../ui/utils/loading_dialog_utils.dart';

import '../../dtos/auth/register_dto.dart';
import '../interfaces/iauth_service.dart';

class AuthService implements IAuthService {
  @override
  Future<bool> register(String name, String email, String password) async {
    LoadingDialogUtils.showLoading();
    try {
      var result = await getRestClient().register(
        RegisterDto(
          firstName: name,
          email: email,
          password: password,
        ),
      );
      if (result.data != null) {
        EasyLoading.showSuccess("Đăng kí thành công!");
        return true;
      } else {
        EasyLoading.showError(result.message ?? "Đăng kí thất bại!");
      }
    } on Exception catch (e) {
      print(e);
    } finally {
      LoadingDialogUtils.hideLoading();
    }
    return false;
  }
  // @override
  // Future<AccountDto?> registerSocial(
  //     String name, String emailAddress, String clientId) async {
  //   LoadingDialogUtils.showLoading();
  //   try {
  //     var result = await getRestClient().registerSocial(
  //       RegisterSocialDto(
  //         name: name,
  //         surName: name,
  //         emailAddress: emailAddress,
  //         clientId: clientId,
  //       ),
  //     );
  //     if (result.result!.accessToken != null) {
  //       TokenUtils.saveToken("Bearer ${result.result!.accessToken}",
  //           result.result!.encryptedAccessToken!);
  //       locator<GlobalData>().token = AccessToken(
  //           accessToken: "Bearer ${result.result!.accessToken}",
  //           userId: result.result!.userId!,
  //           encryptedAccessToken: result.result!.encryptedAccessToken!);
  //       locator<GlobalData>().token!.accessToken =
  //           "Bearer ${result.result!.accessToken}";
  //       BaseApiDto<AccountDto> profileResponseDto;
  //       AccountDto? account;
  //       LoadingDialogUtils.showLoading();

  //       try {
  //         profileResponseDto = await getRestClient().getProfile(
  //           token: locator<GlobalData>().token!.accessToken,
  //         );
  //         account = profileResponseDto.result;
  //         locator<GlobalData>().currentUser = account;
  //         return account;
  //       } on Exception catch (e) {
  //         print(e);
  //       } finally {
  //         LoadingDialogUtils.hideLoading();
  //       }
  //       return null;
  //     } else {
  //       EasyLoading.showError("Đăng kí thất bại!");
  //     }
  //   } on Exception catch (e) {
  //     print(e);
  //   } finally {
  //     LoadingDialogUtils.hideLoading();
  //   }
  //   return null;
  // }

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
          profileResponseDto = await getRestClient()
              .getProfile(token: result.data!.accsess_token.toString());
          account = profileResponseDto.data;
          locator<GlobalData>().currentUser = account;
          locator<GlobalData>().token = result.data!.accsess_token.toString();
          TokenUtils.currentEmail = account!.email.toString();
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

  @override
  Future<void> logOut() async {
    locator<GlobalData>().token = '';
    locator<GlobalData>().currentUser = null;
    await TokenUtils.removeToken();
    Get.offNamed(MyRouter.signIn);
  }
}
