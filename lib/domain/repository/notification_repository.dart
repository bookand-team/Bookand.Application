import '../model/notification/notification_detail_model.dart';
import '../model/notification/notification_model.dart';

abstract class NotificationRepository {
  Future<NotificationModel> getNotificationList(String accessToken, int page);

  Future<NotificationDetailModel> getNotificationDetail(String accessToken, int notificationId);
}
