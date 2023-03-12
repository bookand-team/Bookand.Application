import 'package:bookand/data/datasource/notification/notification_remote_data_source.dart';
import 'package:bookand/data/datasource/notification/notification_remote_data_source_impl.dart';
import 'package:bookand/domain/model/notification/notification_detail_model.dart';
import 'package:bookand/domain/model/notification/notification_model.dart';
import 'package:bookand/domain/repository/notification_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

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
    return await notificationRemoteDataSource.getNotificationDetail(accessToken, notificationId);
  }

  @override
  Future<NotificationModel> getNotificationList(String accessToken, int page) async {
    return await notificationRemoteDataSource.getNotificationList(accessToken, page);
  }
}
