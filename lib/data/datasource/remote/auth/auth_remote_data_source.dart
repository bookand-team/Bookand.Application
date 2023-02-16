import '../../../../core/const/social_type.dart';
import '../../../entity/auth/token_reponse.dart';
import '../../../entity/base_response.dart';

abstract class AuthRemoteDataSource {
  Future<TokenResponse> login(String accessToken, SocialType socialType);

  Future<TokenResponse> signUp(String signToken);

  Future<BaseResponse<String>> logout(String accessToken);
}
