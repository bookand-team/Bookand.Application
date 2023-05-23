import 'package:bookand/domain/model/feedback_model.dart';

abstract interface class FeedbackRepository {
  Future<void> sendFeedback(FeedbackModel feedbackModel);
}
