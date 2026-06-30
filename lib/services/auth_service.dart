import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/user_model.dart';
import '../config/app_config.dart';


class AuthService {
  final String baseUrl = AppConfig.apiBaseUrl;

  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse("$baseUrl/auth/login"),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "email": email,
        "password": password,
      }),
    );

    return jsonDecode(response.body);
  }
  Future<Map<String, dynamic>> register({
  required String name,
  required String email,
  required String password,
}) async {
  final response = await http.post(
    Uri.parse("$baseUrl/auth/register"),
    headers: {
      "Content-Type": "application/json",
    },
    body: jsonEncode({
      "name": name,
      "email": email,
      "password": password,
    }),
  );

  return jsonDecode(response.body);
}
  Future<Map<String, dynamic>> forgotPassword({
  required String email,
}) async {
  final response = await http.post(
    Uri.parse("$baseUrl/auth/forgot-password"),
    headers: {
      "Content-Type": "application/json",
    },
    body: jsonEncode({
      "email": email,
    }),
  );

  final data = jsonDecode(response.body);

  if (response.statusCode == 200) {
    return data;
  }

  throw Exception(
    data["detail"] ?? "Something went wrong",
  );
}
Future<Map<String, dynamic>> verifyOTP({
  required String email,
  required String otp,
}) async {
  final response = await http.post(
    Uri.parse("$baseUrl/auth/verify-otp"),
    headers: {
      "Content-Type": "application/json",
    },
    body: jsonEncode({
      "email": email,
      "otp": otp,
    }),
  );

  final data = jsonDecode(response.body);

  if (response.statusCode == 200) {
    return data;
  }

  throw Exception(
    data["detail"] ?? "OTP Verification Failed",
  );
}
Future<Map<String, dynamic>> resetPassword({
  required String email,
  required String otp,
  required String password,
}) async {
  final response = await http.post(
    Uri.parse("$baseUrl/auth/reset-password"),
    headers: {
      "Content-Type": "application/json",
    },
    body: jsonEncode({
      "email": email,
      "otp": otp,
      "new_password": password,
    }),
  );

  final data = jsonDecode(response.body);

  if (response.statusCode == 200) {
    return data;
  }

  throw Exception(
    data["detail"] ?? "Password reset failed",
  );
}
  Future<UserModel> getCurrentUser(
      String token) async {

    final response = await http.get(
      Uri.parse('$baseUrl/auth/me'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    return UserModel.fromJson(
      jsonDecode(response.body),
    );
  }
}