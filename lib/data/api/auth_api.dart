import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/http.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/config/app_config.dart';
import '../api_helper.dart';
import '../entity/auth/reissue_request.dart';
import '../entity/auth/sign_up_entity.dart';
import '../entity/auth/social_token.dart';
import '../entity/auth/token_reponse.dart';
import '../entity/base_response.dart';

part 'auth_api.g.dart';

@riverpod
AuthApi authApi(AuthApiRef ref) => AuthApi(ApiHelper.create(), baseUrl: AppConfig.instance.baseUrl);

@RestApi()
abstract class AuthApi {
  factory AuthApi(Dio dio, {String baseUrl}) = _AuthApi;

  @POST('/api/v1/auth/login')
  Future<TokenResponse> login(@Body() SocialToken socialToken);

  @POST('/api/v1/auth/signup')
  Future<TokenResponse> signUp(@Body() SignUpEntity signUpEntity);

  @POST('/api/v1/auth/reissue')
  Future<TokenResponse> reissue(@Body() ReissueRequest reissueRequest);

  @GET('/api/v1/auth/logout')
  Future<BaseResponse<String>> logout(@Header('Authorization') String accessToken);
}
