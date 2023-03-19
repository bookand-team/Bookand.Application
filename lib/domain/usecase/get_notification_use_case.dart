import 'package:bookand/data/repository/notification_repository_impl.dart';
import 'package:bookand/domain/model/notification/notification_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../repository/notification_repository.dart';

part 'get_notification_use_case.g.dart';

@riverpod
GetNotificationUseCase getNotificationUseCase(GetNotificationUseCaseRef ref) {
  final repository = ref.read(notificationRepositoryProvider);
  return GetNotificationUseCase(repository);
}

class GetNotificationUseCase {
  final NotificationRepository repository;

  GetNotificationUseCase(this.repository);

  Future<NotificationModel> getNotificationList(int page) async {
    return await repository.getNotificationList(page);
  }
}
