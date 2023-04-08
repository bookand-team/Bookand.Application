import 'dart:isolate';

import 'package:bookand/core/const/notification_constant.dart';
import 'package:bookand/presentation/utils/local_notification.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';

import '../../util/logger.dart';
import 'firebase_options.dart';

FirebaseAnalytics analytics = FirebaseAnalytics.instance;

Future<void> initFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initFirebaseMessaging();
  await initFirebaseCrashlytics();
  await initFirebaseAppCheck();
  await initFirebaseRemoteConfig();
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  if (message.notification != null) {
    LocalNotification.showNotification(
      id: NotificationConstant.fcmId,
      title: message.notification?.title ?? '',
      body: message.notification?.body ?? '',
      androidChannelId: NotificationConstant.fcmChannelId,
      androidChannelName: NotificationConstant.fcmChannelName,
    );
  }
  logger.d("Handling a background message: ${message.messageId}");
}

Future<void> initFirebaseMessaging() async {
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    if (message.notification != null) {
      LocalNotification.showNotification(
        id: NotificationConstant.fcmId,
        title: message.notification?.title ?? '',
        body: message.notification?.body ?? '',
        androidChannelId: NotificationConstant.fcmChannelId,
        androidChannelName: NotificationConstant.fcmChannelName,
      );
    }
    logger.d(message.messageId);
  });
}

Future<void> initFirebaseAppCheck() async {
  await FirebaseAppCheck.instance.activate(
    androidProvider: kDebugMode ? AndroidProvider.debug : AndroidProvider.playIntegrity,
  );
}

Future<void> initFirebaseRemoteConfig() async {
  await FirebaseRemoteConfig.instance.fetchAndActivate();
}

Future<void> initFirebaseCrashlytics() async {
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

  Isolate.current.addErrorListener(RawReceivePort((pair) async {
    final List<dynamic> errorAndStacktrace = pair;
    await FirebaseCrashlytics.instance.recordError(
      errorAndStacktrace.first,
      errorAndStacktrace.last,
      fatal: true,
    );
  }).sendPort);
}
