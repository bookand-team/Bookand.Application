import 'package:bookand/core/app_strings.dart';
import 'package:bookand/core/widget/base_app_bar.dart';
import 'package:bookand/core/widget/base_layout.dart';
import 'package:bookand/presentation/component/custom_switch.dart';
import 'package:bookand/presentation/provider/push_notification_settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NotificationSettingScreen extends ConsumerStatefulWidget {
  static String get routeName => 'notificationSetting';

  const NotificationSettingScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<NotificationSettingScreen> createState() => _NotificationSettingScreenState();
}

class _NotificationSettingScreenState extends ConsumerState<NotificationSettingScreen> {
  @override
  void initState() {
    ref
        .read(pushNotificationSettingsStateNotifierProvider.notifier)
        .fetchPushNotificationSettings();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isEnabled = ref.watch(pushNotificationSettingsStateNotifierProvider);
    final pushNotificationSettingsProvider =
        ref.watch(pushNotificationSettingsStateNotifierProvider.notifier);

    return BaseLayout(
      appBar: const BaseAppBar(
        title: AppStrings.notification,
      ),
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        children: [
          ListTile(
            title: const Text(
              AppStrings.pushNotification,
              style: TextStyle(
                color: Color(0xFF222222),
                fontWeight: FontWeight.w400,
                fontSize: 16,
                letterSpacing: -0.02,
              ),
            ),
            subtitle: const Text(
              AppStrings.pushNotificationDescription,
              style: TextStyle(
                color: Color(0xFFACACAC),
                fontWeight: FontWeight.w400,
                fontSize: 12,
                letterSpacing: -0.02,
              ),
            ),
            trailing: CustomSwitch(
              value: isEnabled,
              onChanged: (value) {
                pushNotificationSettingsProvider.setEnabledPushNotification(value);
              },
            ),
          )
        ],
      ),
    );
  }
}
