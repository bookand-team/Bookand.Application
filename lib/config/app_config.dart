import '../common/const/app_mode.dart';

const String devMode = "dev";
const String productMode = "product";

class AppConfig {
  final String baseUrl;

  AppConfig._dev():
      baseUrl = 'https://dev.bookand.co.kr';

  AppConfig._product():
      baseUrl = 'http://api.bookand.co.kr';

  static late final AppConfig instance;
  static late AppMode appMode;

  factory AppConfig(String? flavor) {
    switch (flavor) {
      case devMode:
        appMode = AppMode.dev;
        instance = AppConfig._dev();
        break;
      case productMode:
        appMode = AppMode.production;
        instance = AppConfig._product();
        break;
      default:
        throw Exception("Unknown flavor : $flavor");
    }

    return instance;
  }
}