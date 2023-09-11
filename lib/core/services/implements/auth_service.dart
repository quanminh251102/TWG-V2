import 'package:shared_preferences/shared_preferences.dart';
import 'package:twg/core/dtos/auth/login_dto.dart';
import 'package:twg/core/utils/token_utils.dart';
import 'package:twg/global/global_data.dart';
import 'package:twg/global/locator.dart';

import '../../../ui/utils/loading_dialog_utils.dart';

import '../interfaces/iauth_service.dart';

class AuthService implements IAuthService {
  @override
  Future<void> login(String emailOrPhone, String password) async {
    LoadingDialogUtils.showLoading();
    try {
      var result = await getRestClient()
          .getToken(LoginDto(email: emailOrPhone, password: password));
      if (result.success) {
        TokenUtils.saveToken("Bearer ${result.data!.accsessToken}");
      }
      var token = await TokenUtils.getToken();
      if (token != null) {
        LoadingDialogUtils.showLoading();
        try {
          // profileResponseDto = await getRestClient().getProfile(token: token);
          // account = profileResponseDto.result;
          // locator<GlobalData>().currentUser = account;
          // return account;
        } on Exception catch (e) {
          print(e);
        } finally {
          LoadingDialogUtils.hideLoading();
        }
      }
      // Response response = await post(Uri.parse(urlLogin),
      //     body: {'email': email, 'password': password});
      // print('Successfully Login');
      // print(response.body);
      // if (response.statusCode == 200) {
      //   final new_t = response.body;
      //   //final new_t = json.encode(jsonData);
      //   final data = json.decode(new_t) as Map<String, dynamic>;

      //   appUser.init(data["user_id"], data["user_name"], data["user_email"],
      //       data["user_avatar"]);

      //   final SharedPreferences prefs = await SharedPreferences.getInstance();
      //   await prefs.setString('email', emailOrPhone);
      //   await prefs.setString('password', password);
      // }
    } on Exception catch (e) {
      print(e);
    } finally {
      LoadingDialogUtils.hideLoading();
    }
  }
}
