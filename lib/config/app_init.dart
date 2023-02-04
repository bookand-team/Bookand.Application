import 'package:flutter/services.dart';

import 'app_config.dart';

Future<void> initApplication() async {
  await _initFlavor();
}

Future<void> _initFlavor() async {
  String? flavor = await const MethodChannel('flavor').invokeMethod<String>('getFlavor');
  AppConfig(flavor);
}
