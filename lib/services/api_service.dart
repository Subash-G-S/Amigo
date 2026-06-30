import '../config/app_config.dart';

class ApiService {
  static String get baseUrl =>
      AppConfig.apiBaseUrl;

  static Uri uri(String endpoint) {
    return Uri.parse(
      "$baseUrl$endpoint",
    );
  }
}