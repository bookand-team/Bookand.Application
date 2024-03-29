import 'package:bookand/data/datasource/notification/notification_remote_data_source.dart';
import 'package:bookand/data/service/notification_service.dart';
import 'package:bookand/domain/model/notification/notification_detail_model.dart';
import 'package:bookand/domain/model/notification/notification_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/util/utf8_util.dart';

part 'notification_remote_data_source_impl.g.dart';

@riverpod
NotificationRemoteDataSource notificationRemoteDataSource(NotificationRemoteDataSourceRef ref) {
  final notificationService = ref.read(notificationServiceProvider);

  return NotificationRemoteDataSourceImpl(notificationService);
}

class NotificationRemoteDataSourceImpl implements NotificationRemoteDataSource {
  final NotificationService service;

  NotificationRemoteDataSourceImpl(this.service);

  @override
  Future<NotificationDetailModel> getNotificationDetail(
      String accessToken, int notificationId) async {
    final resp = await service.getNotificationDetail(accessToken, notificationId);

    if (resp.isSuccessful) {
      return NotificationDetailModel.fromJson(Utf8Util.utf8JsonDecode(resp.bodyString));
    } else {
      throw resp;
    }
  }

  @override
  Future<NotificationModel> getNotificationList(String accessToken, int cursorId, int size) async {
    final resp = await service.getNotificationList(accessToken, cursorId, size);

    if (resp.isSuccessful) {
      return NotificationModel.fromJson(Utf8Util.utf8JsonDecode(resp.bodyString));
    } else {
      throw resp;
    }
  }
}
