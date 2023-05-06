import 'package:bookand/domain/model/feedback_model.dart';

abstract class FeedbackRepository {
  Future<void> sendFeedback(FeedbackModel feedbackModel);
}
