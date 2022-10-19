import 'package:flutter_dotenv/flutter_dotenv.dart';

const String devMode = "dev";
const String productMode = "product";

class AppConfig {
  final String baseUrl;
  final String token;

  AppConfig._dev():
      baseUrl = dotenv.env['BASE_URL_DEV'] ?? "EMPTY_URL",
      token = dotenv.env['TOKEN_DEV'] ?? "EMPTY_TOKEN";

  AppConfig._product():
      baseUrl = dotenv.env['BASE_URL_PRODUCT'] ?? "EMPTY_URL",
      token = dotenv.env['TOKEN_PRODUCT'] ?? "EMPTY_TOKEN";

  static late final AppConfig instance;
  static late final String mode;

  factory AppConfig(String? flavor) {
    switch (flavor) {
      case devMode:
        mode = flavor!;
        instance = AppConfig._dev();
        break;
      case productMode:
        mode = flavor!;
        instance = AppConfig._product();
        break;
      default:
        throw Exception("Unknown flavor : $flavor");
    }

    return instance;
  }
}