import 'package:bookand/core/const/social_type.dart';
import 'package:bookand/domain/model/auth/token_reponse.dart';
import 'package:bookand/domain/model/base_response.dart';

abstract class AuthRemoteDataSource {
  Future<TokenResponse> login(String accessToken, SocialType socialType);

  Future<TokenResponse> signUp(String signToken);

  Future<BaseResponse<String>> logout(String accessToken);
}
