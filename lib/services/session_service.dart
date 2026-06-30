import 'package:shared_preferences/shared_preferences.dart';
import 'token_service.dart';

class SessionService {
  static const String tokenKey = "access_token";
  static const String idKey = "user_id";
  static const String nameKey = "user_name";
  static const String emailKey = "user_email";

  /// Save login session
  static Future<void> saveSession({
    required String token,
    required String id,
    required String name,
    required String email,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    await TokenService.saveToken(token);
    await prefs.setString(idKey, id);
    await prefs.setString(nameKey, name);
    await prefs.setString(emailKey, email);
  }

  /// Get JWT Token
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(tokenKey);
  }

  /// Get User Name
  static Future<String?> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(nameKey);
  }

  /// Get Email
  static Future<String?> getEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(emailKey);
  }

  /// Get User ID
  static Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(idKey);
  }

  /// Is user logged in?
  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.containsKey(tokenKey);
  }

  /// Logout
  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(tokenKey);
    await prefs.remove(idKey);
    await prefs.remove(nameKey);
    await prefs.remove(emailKey);
  }
}