import 'package:bookand/domain/usecase/fcm_use_case.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'push_notification_settings_provider.g.dart';

@riverpod
class PushNotificationSettingsStateNotifier extends _$PushNotificationSettingsStateNotifier {
  final messaging = FirebaseMessaging.instance;
  late final fcmUseCase = ref.read(fcmUseCaseProvider);

  @override
  bool build() {
    fetchPushNotificationSettings();
    return false;
  }

  void fetchPushNotificationSettings() async {
    state = await fcmUseCase.isEnabledPush();
  }

  void setEnabledPushNotification(bool enabled) async {
    final isGranted = await fcmUseCase.requestPermission();

    if (!isGranted) return;

    state = enabled;
    fcmUseCase.setEnabledPush(enabled);
  }
}
