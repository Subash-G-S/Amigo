import 'package:http/http.dart' as http;

import 'token_service.dart';

class LikeService {
  static const String baseUrl =
      "https://e44b-106-192-78-162.ngrok-free.app";

  Future<bool> likePost(String postId) async {
    final token = await TokenService.getToken();

    final response = await http.post(
      Uri.parse("$baseUrl/likes/$postId/like"),
      headers: {
        "Authorization": "Bearer $token",
      },
    );

    return response.statusCode == 200;
  }

  Future<bool> unlikePost(String postId) async {
    final token = await TokenService.getToken();

    final response = await http.delete(
      Uri.parse("$baseUrl/likes/$postId/like"),
      headers: {
        "Authorization": "Bearer $token",
      },
    );

    return response.statusCode == 200;
  }
}