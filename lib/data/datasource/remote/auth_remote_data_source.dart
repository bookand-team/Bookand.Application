import 'package:bookand/data/model/auth/reissue_request.dart';
import 'package:bookand/data/model/auth/social_token.dart';

import '../../model/auth/token_reponse.dart';

abstract class AuthRemoteDataSource {
  Future<TokenResponse> login(SocialToken socialToken);

  Future<TokenResponse> signUp(String signToken);

  Future<TokenResponse> reissue(ReissueRequest reissueRequest);

  Future<String> logout(String accessToken);
}
