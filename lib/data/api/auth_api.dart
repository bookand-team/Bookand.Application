import 'package:bookand/data/model/base_response.dart';
import 'package:bookand/data/model/auth/reissue_request.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/http.dart';

import '../model/auth/social_token.dart';
import '../model/auth/token_reponse.dart';

part 'auth_api.g.dart';

@RestApi()
abstract class AuthApi {
  factory AuthApi(Dio dio, {String baseUrl}) = _AuthApi;

  @POST('/api/v1/auth/login')
  Future<TokenResponse> login(@Body() SocialToken socialToken);

  @POST('/api/v1/auth/signup')
  Future<TokenResponse> signUp(@Body() Map<String, dynamic> body);

  @POST('/api/v1/auth/reissue')
  Future<TokenResponse> reissue(@Body() ReissueRequest reissueRequest);

  @GET('/api/v1/auth/logout')
  Future<BaseResponse<String>> logout(@Header("Authorization") String accessToken);
}
