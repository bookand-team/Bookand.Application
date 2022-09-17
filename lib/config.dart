import 'package:flutter_dotenv/flutter_dotenv.dart';

class Config {
  final String baseUrl;
  final String token;

  Config._dev():
      baseUrl = dotenv.env['BASE_URL_DEV'] ?? "EMPTY_URL",
      token = dotenv.env['TOKEN_DEV'] ?? "EMPTY_TOKEN";

  Config._product():
      baseUrl = dotenv.env['BASE_URL_PRODUCT'] ?? "EMPTY_URL",
      token = dotenv.env['TOKEN_PRODUCT'] ?? "EMPTY_TOKEN";

  factory Config(String? flavor) {
    switch (flavor) {
      case 'dev':
        instance = Config._dev();
        break;
      case 'product':
        instance = Config._product();
        break;
      default:
        throw Exception("Unknown flavor : $flavor");
    }

    return instance;
  }

  static late final Config instance;
}