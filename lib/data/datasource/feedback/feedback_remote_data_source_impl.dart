import 'package:bookand/domain/model/feedback_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../service/feedback_service.dart';
import 'feedback_remote_data_source.dart';

part 'feedback_remote_data_source_impl.g.dart';

@riverpod
FeedbackRemoteDataSource feedbackRemoteDataSource(FeedbackRemoteDataSourceRef ref) {
  final feedbackService = ref.read(feedbackServiceProvider);

  return FeedbackRemoteDataSourceImpl(feedbackService);
}

class FeedbackRemoteDataSourceImpl implements FeedbackRemoteDataSource {
  final FeedbackService service;

  FeedbackRemoteDataSourceImpl(this.service);

  @override
  Future<void> sendFeedback(String accessToken, FeedbackModel feedbackModel) async {
    final resp = await service.sendFeedback(accessToken, feedbackModel.toJson());

    if (!resp.isSuccessful) {
      throw resp;
    }
  }
}
