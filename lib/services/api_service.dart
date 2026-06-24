import 'package:http/http.dart' as http;

class ApiService {
  static Future<http.Response> getRequest(
    String endpoint,
  ) async {
    return await http.get(
      Uri.parse(endpoint),
    );
  }
}