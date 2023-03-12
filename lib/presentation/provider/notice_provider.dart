import 'package:bookand/domain/usecase/get_notification_use_case.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/util/logger.dart';
import '../../domain/model/notification/notification_model.dart';

part 'notice_provider.g.dart';

@riverpod
class NoticeStateNotifier extends _$NoticeStateNotifier {
  bool isLoading = false;
  int page = 1;
  bool isEnd = false;

  @override
  List<NotificationContent> build() => [];

  void fetchNoticeList() async {
    try {
      if (isEnd || isLoading || state.isNotEmpty) return;

      isLoading = true;

      final noticeModel = await ref.read(getNotificationUseCaseProvider).getNotificationList(page);

      if (page == noticeModel.totalPages) {
        isEnd = true;
      }

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

      final noticeModel =
          await ref.read(getNotificationUseCaseProvider).getNotificationList(++page);

      if (page == noticeModel.totalPages) {
        isEnd = true;
      }

      state = [
        ...state,
        ...noticeModel.content,
      ];
    } catch (e) {
      logger.e(e);
    }
  }
}
