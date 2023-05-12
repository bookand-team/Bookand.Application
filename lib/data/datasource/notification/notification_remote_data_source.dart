import 'package:bookand/domain/model/notification/notification_detail_model.dart';

import '../../../domain/model/notification/notification_model.dart';

abstract interface class NotificationRemoteDataSource {
  Future<NotificationModel> getNotificationList(String accessToken, int cursorId, int size);

  Future<NotificationDetailModel> getNotificationDetail(String accessToken, int notificationId);
}
