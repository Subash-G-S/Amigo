import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/user_model.dart';
import '../config/app_config.dart';
import '../models/search_user_model.dart';
import 'token_service.dart';
import '../models/follow_user_model.dart';


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
    String token,
) async {

  final response = await http.get(
    Uri.parse("$baseUrl/auth/me"),
    headers: {
      "Authorization": "Bearer $token",
    },
  );

  if (response.statusCode != 200) {
    throw Exception(
      "Authentication failed (${response.statusCode})",
    );
  }

  final data = jsonDecode(response.body);

  return UserModel.fromJson(
    data["user"],
  );
}

Future<List<SearchUserModel>> searchUsers(
    String query) async {

  final response = await http.get(
    Uri.parse(
      "$baseUrl/auth/search?q=$query",
    ),
  );

  final List data = jsonDecode(response.body);

  return data
      .map(
        (e) => SearchUserModel.fromJson(e),
      )
      .toList();
}
Future<SearchUserModel> getUserProfile(
    String userId) async {

  final response = await http.get(
    Uri.parse(
      "$baseUrl/auth/user/$userId",
    ),
  );

  return SearchUserModel.fromJson(
    jsonDecode(response.body),
  );
}
Future<SearchUserModel> getMyProfile() async {
  final token = await TokenService.getToken();

  final response = await http.get(
    Uri.parse("$baseUrl/auth/profile"),
    headers: {
      "Authorization": "Bearer $token",
    },
  );

  return SearchUserModel.fromJson(
    jsonDecode(response.body),
  );
}
Future<void> updateProfile({
  required String name,
  required String bio,
}) async {
  final token = await TokenService.getToken();

  final response = await http.put(
    Uri.parse("$baseUrl/auth/profile"),
    headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    },
    body: jsonEncode({
      "name": name,
      "bio": bio,
    }),
  );

  if (response.statusCode != 200) {
    throw Exception("Failed to update profile");
  }
}
Future<List<FollowUserModel>> getFollowers(
    String userId) async {

  final response = await http.get(
    Uri.parse(
      "$baseUrl/follow/followers/$userId",
    ),
  );

  final List data = jsonDecode(response.body);

  return data
      .map(
        (e) => FollowUserModel.fromJson(e),
      )
      .toList();
}

Future<List<FollowUserModel>> getFollowing(
    String userId) async {

  final response = await http.get(
    Uri.parse(
      "$baseUrl/follow/following/$userId",
    ),
  );

  final List data = jsonDecode(response.body);

  return data
      .map(
        (e) => FollowUserModel.fromJson(e),
      )
      .toList();
}
}