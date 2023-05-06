import 'package:bookand/core/const/feedback_target.dart';
import 'package:bookand/data/repository/feedback_repository_impl.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/const/feedback_type.dart';
import '../../core/util/logger.dart';
import '../../domain/model/feedback_model.dart';

part 'feedback_provider.freezed.dart';
part 'feedback_provider.g.dart';

@freezed
class FeedbackState with _$FeedbackState {
  const factory FeedbackState({
    required FeedbackModel feedback,
    required bool isLoading,
  }) = _FeedbackState;
}

@riverpod
class FeedbackNotifier extends _$FeedbackNotifier {
  bool isLoading = false;

  @override
  FeedbackState build() => const FeedbackState(feedback: FeedbackModel(), isLoading: false);

  void changeFeedbackType(FeedbackType? feedbackType) {
    final feedback = state.feedback.copyWith(
      feedbackType: feedbackType,
      feedbackTarget: null,
    );
    state = state.copyWith(feedback: feedback);
  }

  void changeFeedbackTarget(FeedbackTarget? feedbackTarget) {
    final feedback = state.feedback.copyWith(feedbackTarget: feedbackTarget);
    state = state.copyWith(feedback: feedback);
  }

  void changeReason(String content) {
    final feedback = state.feedback.copyWith(content: content);
    state = state.copyWith(feedback: feedback);
  }

  Future<void> sendFeedback({
    required Function() onSuccess,
    required Function() onError,
  }) async {
    try {
      state = state.copyWith(isLoading: true);
      await ref.read(feedbackRepositoryProvider).sendFeedback(state.feedback);
      onSuccess();
    } catch (e, stack) {
      logger.e('피드백 보내기 에러', e.toString(), stack);
      onError();
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}
