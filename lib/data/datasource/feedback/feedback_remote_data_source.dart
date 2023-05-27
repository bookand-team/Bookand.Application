import '../../../domain/model/feedback_model.dart';

abstract interface class FeedbackRemoteDataSource {
  Future<void> sendFeedback(String accessToken, FeedbackModel feedbackModel);
}
