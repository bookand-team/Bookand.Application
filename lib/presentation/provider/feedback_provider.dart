import 'package:bookand/core/const/feedback_target.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/const/feedback_type.dart';

part 'feedback_provider.freezed.dart';

part 'feedback_provider.g.dart';

@freezed
class FeedbackState with _$FeedbackState {
  const factory FeedbackState({
    FeedbackTarget? feedbackTarget,
    FeedbackType? feedbackType,
    String? reason,
  }) = _FeedbackState;
}

@riverpod
class FeedbackNotifier extends _$FeedbackNotifier {
  @override
  FeedbackState build() => const FeedbackState();

  void changeFeedbackTarget(FeedbackTarget? feedbackTarget) {
    state = state.copyWith(feedbackTarget: feedbackTarget, feedbackType: null);
  }

  void changeFeedbackType(FeedbackType? feedbackType) {
    state = state.copyWith(feedbackType: feedbackType);
  }

  void changeReason(String value) {
    state = state.copyWith(reason: value);
  }

  Future<void> sendFeedback() async {

  }
}
