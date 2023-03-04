import 'package:bookand/core/app_strings.dart';
import 'package:bookand/domain/usecase/get_me_use_case.dart';
import 'package:bookand/domain/usecase/login_use_case.dart';
import 'package:bookand/domain/usecase/logout_use_case.dart';
import 'package:bookand/domain/usecase/sign_up_use_case.dart';
import 'package:bookand/presentation/provider/auth_provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/const/auth_state.dart';
import '../../core/const/social_type.dart';
import '../../core/const/storage_key.dart';
import '../../core/util/logger.dart';
import '../../domain/model/member/member_model.dart';

part 'member_provider.g.dart';

@Riverpod(keepAlive: true)
class MemberStateNotifier extends _$MemberStateNotifier {
  late final authState = ref.read(authStateNotifierProvider.notifier);
  late final loginUseCase = ref.read(loginUseCaseProvider);
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

  void socialLogin({
    required SocialType socialType,
    required Function(String) onError,
  }) async {
    authState.changeState(AuthState.loading);
    try {
      await loginUseCase.login(
          socialType: socialType,
          onSuccess: () async {
            state = await ref.read(getMeUseCaseProvider).getMe();
            authState.changeState(AuthState.signIn);
          },
          onCancel: () {
            authState.changeState(AuthState.init);
            switch (socialType) {
              case SocialType.NONE:
                onError(AppStrings.loginCancel);
                break;
              case SocialType.GOOGLE:
                onError(AppStrings.googleLoginCancel);
                break;
              case SocialType.APPLE:
                onError(AppStrings.appleLoginCancel);
                break;
            }
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

  void logout() async {
    authState.changeState(AuthState.loading);

    await ref.read(logoutUseCaseProvider).logout(onFinish: () {
      authState.changeState(AuthState.init);
      state = MemberModel();
    });
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

  void cancelSignUp() {
    authState.changeState(AuthState.init);
  }

  void withdrawal() {}
}
