import 'dart:convert';

class Utf8Util {
  static String decode(List<int> bytes) {
    return const Utf8Decoder().convert(bytes);
  }

  static dynamic utf8JsonDecode(String bodyString) {
    return jsonDecode(decode(bodyString.codeUnits));
  }
}
