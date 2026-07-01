import 'dart:convert';
import 'package:http/http.dart' as http;

import '../config/app_config.dart';
import 'token_service.dart';

class FollowService {
  final String baseUrl = AppConfig.apiBaseUrl;

  Future<bool> followUser(String userId) async {
    final token = await TokenService.getToken();

    final response = await http.post(
      Uri.parse("$baseUrl/follow/$userId"),
      headers: {
        "Authorization": "Bearer $token",
      },
    );

    return response.statusCode == 200;
  }

  Future<bool> unfollowUser(String userId) async {
    final token = await TokenService.getToken();

    final response = await http.delete(
      Uri.parse("$baseUrl/follow/$userId"),
      headers: {
        "Authorization": "Bearer $token",
      },
    );

    return response.statusCode == 200;
  }

  Future<bool> isFollowing(String userId) async {
    final token = await TokenService.getToken();

    final response = await http.get(
      Uri.parse("$baseUrl/follow/is-following/$userId"),
      headers: {
        "Authorization": "Bearer $token",
      },
    );

    final data = jsonDecode(response.body);

    return data["following"];
  }
}