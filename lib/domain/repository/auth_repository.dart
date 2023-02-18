import 'package:bookand/core/const/social_type.dart';

import '../model/auth/token_reponse.dart';

abstract class AuthRepository {
  Future<TokenResponse> login(String accessToken, SocialType socialType);

  Future<TokenResponse> signUp(String signToken);

  Future<String> logout(String accessToken);
}
