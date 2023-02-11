import 'dart:io';

import 'package:archive/archive_io.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:easy_debounce/easy_throttle.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shake/shake.dart';

class ShakeLogSender {
  static UserCredential? userCredential;

  static Future<ShakeDetector> getShakeLogSender({
    required Function() onSuccess,
    required Function(String) onError,
  }) async {
    final appDocDir = await getApplicationDocumentsDirectory();
    final logDir = Directory('${appDocDir.path}/logs');
    final isExists = await logDir.exists();

    return ShakeDetector.waitForStart(
      onPhoneShake: () {
        if (!isExists) {
          onError('로그 폴더를 찾을 수 없음.');
          return;
        }

        EasyThrottle.throttle('compression_log_file', const Duration(seconds: 10), () async {
          try {
            final deviceInfoPlugin = DeviceInfoPlugin();
            var deviceInfo = '';

            switch (defaultTargetPlatform) {
              case TargetPlatform.android:
                final androidInfo = await deviceInfoPlugin.androidInfo;
                deviceInfo = '${androidInfo.model}_Android ${androidInfo.version.release}';
                break;
              case TargetPlatform.iOS:
                final iosInfo = await deviceInfoPlugin.iosInfo;
                deviceInfo = '${iosInfo.model}_iOS ${iosInfo.systemVersion}';
                break;
              default:
                deviceInfo = 'UnknownDeviceInfo';
                break;
            }

            final zipFileName = '${deviceInfo}_${DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now())}_logs.zip';
            final zipFilePath = '${appDocDir.path}/$zipFileName';
            _startCompressLogFile(zipFilePath, logDir);
            await _sendLogFile(zipFilePath);
            onSuccess();
          } catch (e) {
            onError(e.toString());
          }
        });
      },
      shakeThresholdGravity: 1.5,
      minimumShakeCount: 1,
    );
  }

  static void _startCompressLogFile(String path, Directory logDir) {
    final encoder = ZipFileEncoder();
    encoder.create(path);
    logDir.listSync().forEach((e) {
      encoder.addFile(File(e.path));
    });
    encoder.close();
  }

  static Future<void> _sendLogFile(String path) async {
    userCredential ??= await FirebaseAuth.instance.signInAnonymously();

    final logFile = File(path);
    final storageRef = FirebaseStorage.instance.ref();
    final logRef = storageRef.child(path.split('/').last);
    await logRef.putFile(logFile);
    File(path).deleteSync();
  }
}
