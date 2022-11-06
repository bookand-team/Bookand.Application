import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'app_config.dart';

Future<void> initFlavor() async {
  String? flavor = await const MethodChannel('flavor').invokeMethod<String>('getFlavor');
  AppConfig(flavor);
}