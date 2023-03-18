import 'package:bookand/data/datasource/notification/notification_remote_data_source.dart';
import 'package:bookand/data/datasource/notification/notification_remote_data_source_impl.dart';
import 'package:bookand/domain/model/notification/notification_detail_model.dart';
import 'package:bookand/domain/model/notification/notification_model.dart';
import 'package:bookand/domain/repository/notification_repository.dart';
import 'package:chopper/chopper.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/util/utf8_util.dart';
import '../../domain/model/error_response.dart';

part 'notification_repository_impl.g.dart';

@riverpod
NotificationRepository notificationRepository(NotificationRepositoryRef ref) {
  final notificationRemoteDataSource = ref.read(notificationRemoteDataSourceProvider);

  return NotificationRepositoryImpl(notificationRemoteDataSource);
}

class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationRemoteDataSource notificationRemoteDataSource;

  NotificationRepositoryImpl(this.notificationRemoteDataSource);

  @override
  Future<NotificationDetailModel> getNotificationDetail(
      String accessToken, int notificationId) async {
    try {
      return await notificationRemoteDataSource.getNotificationDetail(accessToken, notificationId);
    } on Response catch (e) {
      throw ErrorResponse.fromJson(Utf8Util.utf8JsonDecode(e.bodyString));
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<NotificationModel> getNotificationList(String accessToken, int page) async {
    try {
      return await notificationRemoteDataSource.getNotificationList(accessToken, page);
    } on Response catch (e) {
      throw ErrorResponse.fromJson(Utf8Util.utf8JsonDecode(e.bodyString));
    } catch (_) {
      rethrow;
    }
  }
}
