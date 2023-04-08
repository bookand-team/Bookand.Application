import 'package:bookand/core/const/notification_constant.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotification {
  LocalNotification._();

  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static initialize() async {
    const initializationSettingsAndroid = AndroidInitializationSettings('mipmap/ic_launcher');
    const initializationSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );
    const initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  static Future<void> showNotification({
    int id = NotificationConstant.defaultId,
    required String title,
    required String body,
    String androidChannelId = NotificationConstant.defaultChannelId,
    String androidChannelName = NotificationConstant.defaultChannelName,
  }) async {
    final androidNotificationDetails = AndroidNotificationDetails(
      androidChannelId,
      androidChannelName,
      importance: Importance.max,
      priority: Priority.max,
      showWhen: false,
    );
    final notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: const DarwinNotificationDetails(
        badgeNumber: 1,
      ),
    );
    await flutterLocalNotificationsPlugin.show(id, title, body, notificationDetails);
  }
}
