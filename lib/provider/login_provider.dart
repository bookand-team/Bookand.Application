import 'package:bookand/util/error_handler.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../const/social_login_const.dart';

final socialLoginProvider = Provider.autoDispose((ref) {
  return SocialLogin(ref);
});

class SocialLogin with ErrorHandler {
  final Ref ref;

  SocialLogin(this.ref);

  Future<void> login(SocialType type) async {
    switch (type) {
      case SocialType.google:
        return _signInGoogle();
      case SocialType.apple:
        return _signInApple();
      default:
        final error = BaseError(
            value: SocialErrorType.unknownSocialType,
            message: "SocialLogin::login::Unknown social type.");
        return futureError(error);
    }
  }

  Future<void> _signInGoogle() async {
    final googleSignIn = GoogleSignIn();
    final account = await googleSignIn.signIn();
    final auth = await account?.authentication;
    final accessToken = auth?.accessToken;

    debugPrint("테스트: $accessToken");
    if (accessToken == null || accessToken.isEmpty) {
      final error = BaseError(
          value: SocialErrorType.cancel,
          message:
              "SocialLogin::_signInGoogle::Access token is null or empty.");
      return futureError(error);
    }
  }

  void _signInApple() async {
    final credential = await SignInWithApple.getAppleIDCredential(scopes: [
      AppleIDAuthorizationScopes.email,
      AppleIDAuthorizationScopes.fullName
    ]);

    debugPrint(credential.toString());
  }
}
