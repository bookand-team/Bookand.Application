import 'dart:async';
import 'dart:io';

import 'package:bookand/data/repository/push_repository_impl.dart';
import 'package:bookand/domain/repository/push_repository.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/util/logger.dart';

part 'fcm_use_case.g.dart';

@riverpod
FCMUseCase fcmUseCase(FcmUseCaseRef ref) {
  final messaging = FirebaseMessaging.instance;
  final pushRepository = ref.read(pushRepositoryProvider);

  return FCMUseCase(messaging, pushRepository);
}

class FCMUseCase {
  final FirebaseMessaging messaging;
  final PushRepository pushRepository;

  FCMUseCase(this.messaging, this.pushRepository);

  Future<String> getToken() async {
    final token = await messaging.getToken();
    logger.d("FCM 토큰: $token");
    return token ?? 'N/A';
  }

  void updateApiServerFCMToken() async {
    // final token = await getToken();
    // TODO: 서버에 fcm 토큰 저장
  }

  void refreshFCMToken() async {
    final isEnabled = await isEnabledPush();
    if (!isEnabled) return;

    await messaging.deleteToken();
    updateApiServerFCMToken();
  }

  Future<bool> isEnabledPush() async {
    return await pushRepository.isEnabledPush();
  }

  void setEnabledPush(bool enabled) async {
    pushRepository.setEnabledPush(enabled);

    if (enabled) {
      updateApiServerFCMToken();
    } else {
      await messaging.deleteToken();
    }
  }

  Future<bool> requestPermission() async {
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

    final authStatus = settings.authorizationStatus;
    logger.i('알림 권한 상태: $authStatus');

    // TODO: 경우에 따라서 분기별 처리가 더 필요할듯?
    switch (authStatus) {
      case AuthorizationStatus.authorized:
        return true;
      case AuthorizationStatus.denied:
      case AuthorizationStatus.notDetermined:
      case AuthorizationStatus.provisional:
        return false;
    }
  }
}
