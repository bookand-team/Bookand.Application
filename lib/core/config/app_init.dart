import 'package:bookand/presentation/utils/local_notification.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../domain/model/policy_model.dart';
import '../const/hive_key.dart';
import 'app_config.dart';

Future<void> initApplication() async {
  await _initFlavor();
  await _initHive();
  LocalNotification.initialize();
}

Future<void> _initFlavor() async {
  String? flavor = await const MethodChannel('flavor').invokeMethod<String>('getFlavor');
  AppConfig(flavor);
}

Future<void> _initHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(PolicyModelAdapter());
  await Hive.openBox(HiveKey.policyBoxKey);
  await Hive.openBox(HiveKey.enabledPushNotificationBoxKey);
}
