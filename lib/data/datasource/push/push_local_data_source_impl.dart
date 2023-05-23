import 'package:bookand/data/datasource/push/push_local_data_source.dart';
import 'package:hive/hive.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/const/hive_key.dart';

part 'push_local_data_source_impl.g.dart';

@riverpod
PushLocalDataSource pushLocalDataSource(PushLocalDataSourceRef ref) {
  final box = Hive.box(HiveKey.enabledPushNotificationBoxKey);

  return PushLocalDataSourceImpl(box);
}

class PushLocalDataSourceImpl implements PushLocalDataSource {
  final enabledPushNotificationKey = 'enabledPushNotificationKey';
  final Box box;

  PushLocalDataSourceImpl(this.box);

  @override
  Future<bool> isEnabledPush() async {
    return await box.get(enabledPushNotificationKey) ?? false;
  }

  @override
  Future<void> setEnabledPush(bool enabled) async {
    await box.put(enabledPushNotificationKey, enabled);
  }
}
