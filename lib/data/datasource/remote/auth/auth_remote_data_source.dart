import '../../../../core/const/social_type.dart';
import '../../../entity/auth/token_reponse.dart';

abstract class AuthRemoteDataSource {
  Future<TokenResponse> login(String accessToken, SocialType socialType);

  Future<TokenResponse> signUp(String signToken);

  Future<TokenResponse> reissue(String refreshToken);

  Future<String> logout(String accessToken);
}
