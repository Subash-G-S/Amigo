import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../config/api_config.dart';
import 'token_service.dart';

class UploadService {
  Future<String?> uploadProfilePhoto(File imageFile) async {
    final token = await TokenService.getToken();

    var request = http.MultipartRequest(
      "PUT",
      Uri.parse("${ApiConfig.baseUrl}/upload/profile-photo"),
    );

    request.headers["Authorization"] = "Bearer $token";

    request.files.add(
      await http.MultipartFile.fromPath(
        "image",
        imageFile.path,
      ),
    );

    final response = await request.send();
    final body = await response.stream.bytesToString();
    print("STATUS: ${response.statusCode}");
    print("BODY: $body");

    if (response.statusCode == 200) {
      

      final json = jsonDecode(body);

      return json["profile_picture"];
    }

    return null;
  }
}