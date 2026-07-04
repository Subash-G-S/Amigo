import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/post_model.dart';
import 'package:amigo/services/token_service.dart';
import '../config/app_config.dart';

class PostService {
  final String baseUrl = AppConfig.apiBaseUrl;

  Future<List<PostModel>> getFeed() async {
    final token = await TokenService.getToken();

    final response = await http.get(
      Uri.parse("$baseUrl/posts/feed"),
      headers: {
        "Authorization": "Bearer $token",
      },
    );

    final List data = jsonDecode(response.body);

    return data
        .map((e) => PostModel.fromJson(e))
        .toList();
  }
  Future<bool> createPost(
    String content,
    bool isAnonymous,
  ) async {

  final token = await TokenService.getToken();
  print("=========== CREATE POST ===========");
  print("BASE URL: $baseUrl");
  print("TOKEN: $token");

  final response = await http.post(
    Uri.parse("$baseUrl/posts/create"),
    headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    },
    body: jsonEncode({
      "content": content,
      "is_anonymous": isAnonymous,
    }),
  );
  print("STATUS CODE: ${response.statusCode}");
  print("RESPONSE BODY: ${response.body}");
  print("===================================");

  return response.statusCode == 200;
}
}