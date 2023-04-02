import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/util/logger.dart';
import '../../data/repository/notification_repository_impl.dart';
import '../../domain/model/notification/notification_model.dart';

part 'notice_provider.g.dart';

@riverpod
class NoticeStateNotifier extends _$NoticeStateNotifier {
  late final notificationRepository = ref.read(notificationRepositoryProvider);
  bool isLoading = false;
  bool isEnd = false;
  int cursorId = 0;
  int size = 15;

  @override
  List<NotificationContent> build() => [];

  void fetchNoticeList() async {
    try {
      isLoading = true;
      cursorId = 0;
      final noticeModel = await notificationRepository.getNotificationList(cursorId, size);
      cursorId = noticeModel.content.last.id;
      isEnd = noticeModel.last;
      state = noticeModel.content;
    } catch (e) {
      logger.e(e);
    } finally {
      isLoading = false;
    }
  }

  void fetchNextNoticeList() async {
    try {
      if (!isLoading && isEnd) return;

      isLoading = true;
      final noticeModel = await notificationRepository.getNotificationList(cursorId, size);
      isEnd = noticeModel.last;
      state = [
        ...state,
        ...noticeModel.content,
      ];
    } catch (e) {
      logger.e(e);
    } finally {
      isLoading = false;
    }
  }
}
