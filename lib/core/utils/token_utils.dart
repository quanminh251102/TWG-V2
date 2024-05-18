import 'package:shared_preferences/shared_preferences.dart';

class TokenUtils {
  static const String key = 'token';
  static const String encryptedAccessTokenKey = 'encryptedAccessToken';
  static String currentEmail = '';

  static Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  static Future<String?> getencryptedAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(encryptedAccessTokenKey);
  }

  static Future<void> saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, token);
  }

  static Future<void> removeToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
    prefs.remove(encryptedAccessTokenKey);
  }
}
