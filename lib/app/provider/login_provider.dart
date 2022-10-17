import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

enum SocialType {
  google,
  apple
}

final socialLoginProvider = Provider.autoDispose((ref) {
  return SocialLogin(ref);
});

class SocialLogin {
  final Ref ref;

  SocialLogin(this.ref);

  Future<void> login(SocialType type) async {
    try {
      switch (type) {
        case SocialType.google:
          _signInGoogle();
          break;
        case SocialType.apple:
          _signInApple();
          break;
        default:
          throw Exception("SocialLogin::login::Unknown Social Type.");
      }
    } catch (e) {
      debugPrint("SocialLogin::login::${e.toString()}");
    }
  }

  void _signInGoogle() async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    final account = await googleSignIn.signIn();
    final auth = await account?.authentication;
    final accessToken = auth?.accessToken;
    debugPrint("테스트: $accessToken");
  }

  void _signInApple() {

  }
}