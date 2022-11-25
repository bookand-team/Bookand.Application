const String devMode = "dev";
const String productMode = "product";

class AppConfig {
  final String baseUrl;

  AppConfig._dev():
      baseUrl = 'https://dev.bookand.co.kr';

  AppConfig._product():
      baseUrl = 'https://api.bookand.co.kr';

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