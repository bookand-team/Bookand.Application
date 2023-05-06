import 'package:chopper/chopper.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../api_helper.dart';

part 'feedback_service.chopper.dart';
part 'feedback_service.g.dart';

@riverpod
FeedbackService feedbackService(FeedbackServiceRef ref) =>
    FeedbackService.create(ApiHelper.client());

@ChopperApi(baseUrl: '/api/v1/feedbacks')
abstract class FeedbackService extends ChopperService {
  static FeedbackService create([ChopperClient? client]) => _$FeedbackService(client);

  @Post()
  Future<Response> sendFeedback(
      @Header('Authorization') String accessToken, @Body() Map<String, dynamic> body);
}
