import 'package:bookand/data/repository/notification_repository_impl.dart';
import 'package:bookand/domain/model/notification/notification_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/const/storage_key.dart';
import '../repository/notification_repository.dart';

part 'get_notification_use_case.g.dart';

@riverpod
GetNotificationUseCase getNotificationUseCase(GetNotificationUseCaseRef ref) {
  final repository = ref.read(notificationRepositoryProvider);
  const storage = FlutterSecureStorage();

  return GetNotificationUseCase(repository, storage);
}

class GetNotificationUseCase {
  final NotificationRepository repository;
  final FlutterSecureStorage storage;

  GetNotificationUseCase(this.repository, this.storage);

  Future<NotificationModel> getNotificationList(int page) async {
    final accessToken = await storage.read(key: accessTokenKey);
    return await repository.getNotificationList(accessToken!, page);
  }
}
