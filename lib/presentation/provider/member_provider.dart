import 'package:bookand/core/app_strings.dart';
import 'package:bookand/domain/usecase/get_me_use_case.dart';
import 'package:bookand/domain/usecase/login_use_case.dart';
import 'package:bookand/domain/usecase/logout_use_case.dart';
import 'package:bookand/domain/usecase/sign_up_use_case.dart';
import 'package:bookand/presentation/provider/auth_provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../core/const/auth_state.dart';
import '../../core/const/social_type.dart';
import '../../core/const/storage_key.dart';
import '../../core/util/logger.dart';
import '../../domain/model/member/member_model.dart';

part 'member_provider.g.dart';

@Riverpod(keepAlive: true)
class MemberStateNotifier extends _$MemberStateNotifier {
  late final authState = ref.read(authStateNotifierProvider.notifier);
  late final storage = const FlutterSecureStorage();

  @override
  MemberModel build() {
    fetchMemberInfo();
    return MemberModel();
  }

  void fetchMemberInfo() {
    ref.read(getMeUseCaseProvider).getMe().then((member) {
      state = member;
      authState.changeState(AuthState.signIn);
    }, onError: (e, stack) {
      logger.e('사용자 정보를 가져오는데 실패', e, stack);
      authState.changeState(AuthState.init);
    });
  }

  void googleLogin({required Function(String) onError}) async {
    authState.changeState(AuthState.loading);
    try {
      final googleSignIn = GoogleSignIn();
      final account = await googleSignIn.signIn();
      final auth = await account?.authentication;
      final googleAccessToken = auth?.accessToken;

      if (googleAccessToken == null) {
        authState.changeState(AuthState.init);
        onError(AppStrings.googleLoginCancel);
        return;
      }

      await ref.read(loginUseCaseProvider).login(
          accessToken: googleAccessToken,
          socialType: SocialType.GOOGLE,
          onSuccess: () async {
            state = await ref.read(getMeUseCaseProvider).getMe();
            authState.changeState(AuthState.signIn);
          },
          onSignUp: (signToken) async {
            authState.changeState(AuthState.signUp);
            await storage.write(key: signTokenKey, value: signToken);
          });
    } catch (e, stack) {
      logger.e('로그인 에러', e, stack);
      authState.changeState(AuthState.init);
      onError('${AppStrings.loggingInError}\n에러: ${e.toString()}');
    }
  }

  void appleLogin({required Function(String) onError}) async {
    authState.changeState(AuthState.loading);
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
          socialType: SocialType.APPLE,
          onSuccess: () async {
            state = await ref.read(getMeUseCaseProvider).getMe();
            authState.changeState(AuthState.signIn);
          },
          onSignUp: (signToken) async {
            await storage.write(key: signTokenKey, value: signToken);
            authState.changeState(AuthState.signUp);
          });
    } catch (e) {
      logger.e(e);
      authState.changeState(AuthState.init);
      onError('${AppStrings.loggingInError}\n에러: ${e.toString()}');
    }
  }

  Future<void> signUp() async {
    final signToken = await storage.read(key: signTokenKey);

    authState.changeState(AuthState.loading);

    try {
      await ref.read(signUpUseCaseProvider).signUp(signToken!);
      state = await ref.read(getMeUseCaseProvider).getMe();
      authState.changeState(AuthState.signIn);
    } catch (e) {
      logger.e(e);
      authState.changeState(AuthState.signUp);
      return Future.error(e);
    }
  }

  void logout() async {
    authState.changeState(AuthState.loading);

    await ref.read(logoutUseCaseProvider).logout(onFinish: () {
      authState.changeState(AuthState.init);
      state = MemberModel();
    });
  }

  void cancelSignUp() {
    authState.changeState(AuthState.init);
  }
}
