import 'package:freezed_annotation/freezed_annotation.dart';

import '../../core/const/feedback_target.dart';
import '../../core/const/feedback_type.dart';
import '../../core/const/platform_type.dart';

part 'feedback_model.freezed.dart';

part 'feedback_model.g.dart';

@freezed
class FeedbackModel with _$FeedbackModel {
  const factory FeedbackModel({
    FeedbackType? feedbackType,
    FeedbackTarget? feedbackTarget,
    String? content,
    PlatformType? deviceOS
  }) = _FeedbackState;

  factory FeedbackModel.fromJson(Map<String, Object?> json) => _$FeedbackModelFromJson(json);
}
