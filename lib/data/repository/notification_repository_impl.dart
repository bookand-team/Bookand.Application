import 'package:bookand/data/datasource/notification/notification_remote_data_source.dart';
import 'package:bookand/data/datasource/notification/notification_remote_data_source_impl.dart';
import 'package:bookand/data/datasource/token/token_local_data_source.dart';
import 'package:bookand/data/datasource/token/token_local_data_source_impl.dart';
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
  final tokenLocalDataSource = ref.read(tokenLocalDataSourceProvider);

  return NotificationRepositoryImpl(notificationRemoteDataSource, tokenLocalDataSource);
}

class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationRemoteDataSource notificationRemoteDataSource;
  final TokenLocalDataSource tokenLocalDataSource;

  NotificationRepositoryImpl(this.notificationRemoteDataSource, this.tokenLocalDataSource);

  @override
  Future<NotificationDetailModel> getNotificationDetail(int notificationId) async {
    try {
      final accessToken = await tokenLocalDataSource.getAccessToken();
      return await notificationRemoteDataSource.getNotificationDetail(accessToken, notificationId);
    } on Response catch (e) {
      throw ErrorResponse.fromJson(Utf8Util.utf8JsonDecode(e.bodyString));
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<NotificationModel> getNotificationList(int page) async {
    try {
      final accessToken = await tokenLocalDataSource.getAccessToken();
      return await notificationRemoteDataSource.getNotificationList(accessToken, page);
    } on Response catch (e) {
      throw ErrorResponse.fromJson(Utf8Util.utf8JsonDecode(e.bodyString));
    } catch (_) {
      rethrow;
    }
  }
}
