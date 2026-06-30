import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  static String get apiBaseUrl =>
      dotenv.env["API_BASE_URL"]!;

  static String get appName =>
      dotenv.env["APP_NAME"] ?? "AMIGO";

  static String get environment =>
      dotenv.env["APP_ENV"] ?? "development";
}