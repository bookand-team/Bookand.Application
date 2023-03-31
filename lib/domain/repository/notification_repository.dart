import '../model/notification/notification_detail_model.dart';
import '../model/notification/notification_model.dart';

abstract class NotificationRepository {
  Future<NotificationModel> getNotificationList(int cursorId);

  Future<NotificationDetailModel> getNotificationDetail(int notificationId);
}
