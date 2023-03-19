import 'package:bookand/core/const/social_type.dart';

abstract class AuthRepository {
  Future<void> login(String socialAccessToken, SocialType socialType);

  Future<void> signUp();

  Future<String> logout();
}
