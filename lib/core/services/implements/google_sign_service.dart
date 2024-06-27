import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:twg/constants.dart';
import 'package:twg/core/dtos/auth/account_dto.dart';
import 'package:twg/core/dtos/auth/login_dto.dart';
import 'package:twg/core/dtos/base_api_dto.dart';
import 'package:twg/core/services/interfaces/iauth_service.dart';
import 'package:twg/core/services/interfaces/igoogle_sign_service.dart';
import 'package:twg/core/utils/token_utils.dart';
import 'package:twg/global/global_data.dart';
import 'package:twg/global/locator.dart';
import 'package:twg/ui/utils/loading_dialog_utils.dart';

class GoogleSignInService implements IGoogleSignInService {
  GoogleSignInAccount? _currentUser;
  final IAuthService _iAuthService = locator<IAuthService>();
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  AccountDto fromGoogleSignInAccount(GoogleSignInAccount account) {
    return AccountDto(
      firstName: account.displayName?.split(' ').first,
      lastName: account.displayName?.split(' ').last,
      email: account.email,
      avatarUrl: account.photoUrl,
      id: account.id,
      online: true,
      createdAt: DateTime.now().toIso8601String(),
      updatedAt: DateTime.now().toIso8601String(),
    );
  }

  @override
  Future<AccountDto?> loginGoogle() async {
    LoadingDialogUtils.showLoading();
    GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    if (googleUser != null) {
      try {
        final register = await _iAuthService.register(
          googleUser.displayName!,
          googleUser.email,
          googleUser.email,
        );
        if (register) {
          var result = await getRestClient().getToken(
            LoginDto(
              email: googleUser.email,
              password: googleUser.email,
            ),
          );
          if (result.success) {
            TokenUtils.saveToken(result.data!.accsess_token ?? "");
          }
          locator<GlobalData>().currentUser =
              fromGoogleSignInAccount(googleUser);
          locator<GlobalData>().token = result.data!.accsess_token.toString();
          TokenUtils.currentEmail = googleUser.email.toString();
        }
      } on Exception catch (e) {
        print(e);
      } finally {
        LoadingDialogUtils.hideLoading();
      }
    }

    if (locator<GlobalData>().currentUser != null) {
      return locator<GlobalData>().currentUser;
    }
    return null;
  }
}
