import 'package:http/http.dart' as http;

import 'token_service.dart';
import '../config/app_config.dart';


class LikeService {
  final String baseUrl = AppConfig.apiBaseUrl;

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