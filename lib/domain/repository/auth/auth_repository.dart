import '../../../core/const/social_type.dart';
import '../../model/token.dart';

abstract class AuthRepository {
  Future<Token> login(String accessToken, SocialType socialType);

  Future<Token> signUp(String signToken);

  Future<String> logout(String accessToken);
}
