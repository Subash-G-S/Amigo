import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/post_model.dart';
import 'package:amigo/services/token_service.dart';

class PostService {
  static const String baseUrl =
      "https://86f7-106-192-67-242.ngrok-free.app";

  Future<List<PostModel>> getFeed() async {
    final response = await http.get(
      Uri.parse("$baseUrl/posts/feed"),
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