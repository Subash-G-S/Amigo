import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/comment_model.dart';
import 'token_service.dart';
import '../config/app_config.dart';


class CommentService {
  final String baseUrl = AppConfig.apiBaseUrl;

  Future<List<CommentModel>> getComments(
      String postId) async {

    final token =
        await TokenService.getToken();

    final response = await http.get(
      Uri.parse(
          "$baseUrl/comments/$postId"),
      headers: {
        "Authorization": "Bearer $token",
      },
    );

    final List data =
        jsonDecode(response.body);

    return data
        .map((e) => CommentModel.fromJson(e))
        .toList();
  }

  Future<bool> addComment(
      String postId,
      String text) async {

    final token =
        await TokenService.getToken();

    final response = await http.post(
      Uri.parse(
          "$baseUrl/comments/create/$postId"),
      headers: {
        "Authorization":
            "Bearer $token",
        "Content-Type":
            "application/json",
      },
      body: jsonEncode({
        "content": text,
      }),
    );

    return response.statusCode == 200;
  }
}