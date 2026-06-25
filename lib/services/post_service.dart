import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/post_model.dart';
import 'package:amigo/services/token_service.dart';

class PostService {
  static const String baseUrl =
      "https://e44b-106-192-78-162.ngrok-free.app";

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
  Future<bool> createPost(String content) async {

  final token = await TokenService.getToken();

  final response = await http.post(
    Uri.parse("$baseUrl/posts/create"),
    headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    },
    body: jsonEncode({
      "content": content,
    }),
  );

  return response.statusCode == 200;
}
}