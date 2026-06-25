import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/user_model.dart';

class AuthService {
  static const String baseUrl =
      "https://86f7-106-192-67-242.ngrok-free.app";

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