import 'dart:io';

import 'package:bookand/presentation/screen/const/pref_key.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/util/logger.dart';

class FcmService {
  static final messaging = FirebaseMessaging.instance;

  static Future<void> setEnabledPushNotification(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(PrefKey.enabledPushNotificationKey, enabled);
  }

  static Future<bool> isEnabledPushNotification() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(PrefKey.enabledPushNotificationKey) ?? false;
  }

  static Future<String?> getToken() async {
    final fcmToken = await messaging.getToken();
    logger.d("FCM 토큰: $fcmToken");
    return fcmToken;
  }

  static void requestPermission() async {
    if (Platform.isIOS) {
      await messaging.setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
    }

    final settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    logger.d('User granted permission: ${settings.authorizationStatus}');
  }
}
