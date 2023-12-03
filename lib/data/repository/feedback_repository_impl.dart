import 'package:bookand/data/datasource/feedback/feedback_remote_data_source_impl.dart';
import 'package:bookand/domain/model/feedback_model.dart';
import 'package:chopper/chopper.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/util/utf8_util.dart';
import '../../domain/model/error_response.dart';
import '../../domain/repository/feedback_repository.dart';
import '../datasource/feedback/feedback_remote_data_source.dart';
import '../datasource/token/token_local_data_source.dart';
import '../datasource/token/token_local_data_source_impl.dart';

part 'feedback_repository_impl.g.dart';

@riverpod
FeedbackRepository feedbackRepository(FeedbackRepositoryRef ref) {
  final feedbackRemoteDataSource = ref.read(feedbackRemoteDataSourceProvider);
  final tokenLocalDataSource = ref.read(tokenLocalDataSourceProvider);
  return FeedbackRepositoryImpl(feedbackRemoteDataSource, tokenLocalDataSource);
}

class FeedbackRepositoryImpl implements FeedbackRepository {
  final FeedbackRemoteDataSource feedbackRemoteDataSource;
  final TokenLocalDataSource tokenLocalDataSource;

  FeedbackRepositoryImpl(this.feedbackRemoteDataSource, this.tokenLocalDataSource);

  @override
  Future<void> sendFeedback(FeedbackModel feedbackModel) async {
    try {
      final accessToken = await tokenLocalDataSource.getAccessToken();
      await feedbackRemoteDataSource.sendFeedback(accessToken, feedbackModel);
    } on Response catch (e) {
      throw ErrorResponse.fromJson(Utf8Util.utf8JsonDecode(e.bodyString));
    } catch (_) {
      rethrow;
    }
  }
}
