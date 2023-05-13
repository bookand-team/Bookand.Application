import '../../../domain/model/feedback_model.dart';

abstract class FeedbackRemoteDataSource {
  Future<void> sendFeedback(String accessToken, FeedbackModel feedbackModel);
}
