import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'logger.dart';

Future<Uint8List> getEncryptionKey() async {
  final key = await const FlutterSecureStorage().read(key: 'key');

  if (key == null) {
    const message = 'getEncryptionKey::key값이 null임';
    logger.e(message);
    return Future.error(message);
  }

  final encryptionKey = base64Url.decode(key);
  return encryptionKey;
}