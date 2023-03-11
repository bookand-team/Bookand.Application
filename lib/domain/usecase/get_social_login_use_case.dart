import 'package:google_sign_in/google_sign_in.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../core/const/social_type.dart';

part 'get_social_login_use_case.g.dart';

@riverpod
GetSocialAccessTokenUseCase getSocialAccessTokenUseCase(GetSocialAccessTokenUseCaseRef ref) =>
    GetSocialAccessTokenUseCase();

class GetSocialAccessTokenUseCase {
  Future<String?>? getSocialAccessToken(SocialType socialType) {
    final Map<SocialType, SocialLogin> socialLogins = {
      SocialType.GOOGLE: GoogleLogin(),
      SocialType.APPLE: AppleLogin(),
    };

    return socialLogins[socialType]?.getSocialAccessToken();
  }
}

abstract class SocialLogin {
  Future<String?> getSocialAccessToken();
}

class GoogleLogin implements SocialLogin {
  @override
  Future<String?> getSocialAccessToken() async {
    final googleSignIn = GoogleSignIn();
    final account = await googleSignIn.signIn();
    final auth = await account?.authentication;
    return auth?.accessToken;
  }
}

class AppleLogin implements SocialLogin {
  @override
  Future<String?> getSocialAccessToken() async {
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );
      return credential.identityToken;
    } on SignInWithAppleAuthorizationException catch (e) {
      if (e.code == AuthorizationErrorCode.canceled) {
        return null;
      } else {
        rethrow;
      }
    }
  }
}
