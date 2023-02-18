import 'package:bookand/core/app_strings.dart';
import 'package:bookand/domain/model/member/member_model.dart';
import 'package:bookand/domain/usecase/get_me_use_case.dart';
import 'package:bookand/domain/usecase/login_use_case.dart';
import 'package:bookand/domain/usecase/logout_use_case.dart';
import 'package:bookand/domain/usecase/sign_up_use_case.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../core/const/social_type.dart';
import '../../core/util/logger.dart';

part 'member_provider.g.dart';

@Riverpod(keepAlive: true)
class MemberStateNotifier extends _$MemberStateNotifier {
  @override
  MemberModelBase build() {
    ref.read(getMeUseCaseProvider).getMe().then((member) {
      state = member;
    }).onError((e, stack) {
      logger.e('사용자 정보를 가져오는데 실패', e, stack);
      state = MemberModelInit();
    });

    return MemberModelLoading();
  }

  void googleLogin({required Function(String) onError}) async {
    state = MemberModelLoading();
    try {
      final googleSignIn = GoogleSignIn();
      final account = await googleSignIn.signIn();
      final auth = await account?.authentication;
      final googleAccessToken = auth?.accessToken;

      if (googleAccessToken == null) {
        state = MemberModelInit();
        onError(AppStrings.googleLoginCancel);
        return;
      }

      await ref.read(loginUseCaseProvider).login(
          accessToken: googleAccessToken,
          socialType: SocialType.google,
          onSuccess: () async {
            state = await ref.read(getMeUseCaseProvider).getMe();
          },
          onSignUp: () {
            state = MemberModelSignUp();
          });
    } catch (e, stack) {
      logger.e('로그인 에러', e, stack);
      state = MemberModelError();
      onError('${AppStrings.loggingInError}\n에러: ${e.toString()}');
    }
  }

  void appleLogin({required Function(String) onError}) async {
    state = MemberModelLoading();
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      if (credential.identityToken == null) {
        onError(AppStrings.appleLoginCancel);
        return;
      }

      await ref.read(loginUseCaseProvider).login(
          accessToken: credential.identityToken!,
          socialType: SocialType.apple,
          onSuccess: () async {
            state = await ref.read(getMeUseCaseProvider).getMe();
          },
          onSignUp: () {
            state = MemberModelSignUp();
          });
    } catch (e) {
      logger.e(e);
      state = MemberModelError();
      onError('${AppStrings.loggingInError}\n에러: ${e.toString()}');
    }
  }

  Future<void> signUp() async {
    state = MemberModelLoading();

    try {
      await ref.read(signUpUseCaseProvider).signUp();
      state = await ref.read(getMeUseCaseProvider).getMe();
    } catch (e) {
      logger.e(e);
      state = MemberModelError();
      return Future.error(e);
    }
  }

  void logout() async {
    state = MemberModelLoading();

    await ref.read(logoutUseCaseProvider).logout(onFinish: () {
      state = MemberModelInit();
    });
  }

  void cancelSignUp() {
    state = MemberModelInit();
  }
}
