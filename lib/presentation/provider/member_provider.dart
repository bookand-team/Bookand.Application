import 'package:bookand/core/app_strings.dart';
import 'package:bookand/core/const/revoke_type.dart';
import 'package:bookand/domain/usecase/fcm_use_case.dart';
import 'package:bookand/domain/usecase/get_social_login_use_case.dart';
import 'package:bookand/domain/usecase/login_use_case.dart';
import 'package:bookand/domain/usecase/logout_use_case.dart';
import 'package:bookand/domain/usecase/sign_up_use_case.dart';
import 'package:bookand/domain/usecase/withdrawal_use_case.dart';
import 'package:bookand/presentation/provider/auth_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/const/auth_state.dart';
import '../../core/const/social_type.dart';
import '../../core/util/logger.dart';
import '../../data/repository/member_repository_impl.dart';
import '../../domain/model/error_response.dart';
import '../../domain/model/member/member_model.dart';

part 'member_provider.g.dart';

@Riverpod(keepAlive: true)
class MemberStateNotifier extends _$MemberStateNotifier {
  late final authState = ref.read(authStateNotifierProvider.notifier);
  late final getSocialAccessTokenUseCase = ref.read(getSocialAccessTokenUseCaseProvider);
  late final loginUseCase = ref.read(loginUseCaseProvider);
  late final withdrawalUseCase = ref.read(withdrawalUseCaseProvider);
  late final memberRepository = ref.read(memberRepositoryProvider);

  @override
  MemberModel build() => MemberModel();

  void fetchMemberInfo() async {
    try {
      state = await memberRepository.getMe();
      authState.changeState(AuthState.signIn);
      ref.read(fcmUseCaseProvider).refreshFCMToken();
    } catch (e) {
      logger.e('사용자 정보를 가져오는데 실패', e);
      authState.changeState(AuthState.init);
    }
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
            state = await memberRepository.getMe();
            authState.changeState(AuthState.signIn);
          },
          onCancel: () {
            authState.changeState(AuthState.init);
            onError(AppStrings.loginCancel);
          },
          onSignUp: () {
            authState.changeState(AuthState.signUp);
          });
    } on ErrorResponse catch (e, stack) {
      logger.e('[${e.code}] ${e.message}', e.log, stack);
      authState.changeState(AuthState.init);
      onError('${AppStrings.loggingInError}\n[${e.code}]');
    } catch (e, stack) {
      logger.e('로그인 에러', e, stack);
      authState.changeState(AuthState.init);
      onError('${AppStrings.loggingInError}\n에러: ${e.toString()}');
    }
  }

  void logout() async {
    authState.changeState(AuthState.loading);
    await ref.read(logoutUseCaseProvider).logout();
    authState.changeState(AuthState.init);
    state = MemberModel();
  }

  Future<void> signUp() async {
    authState.changeState(AuthState.loading);

    try {
      state = await ref.read(signUpUseCaseProvider).signUp();
      authState.changeState(AuthState.welcome);
    } catch (e) {
      logger.e(e);
      authState.changeState(AuthState.signUp);
      return Future.error(e);
    }
  }

  void cancelSignUp() {
    authState.changeState(AuthState.init);
  }

  Future<void> getSocialAccessToken({
    required SocialType socialType,
    required Function(String token) onSuccess,
    required Function(String error) onError,
  }) async {
    try {
      final socialToken = await getSocialAccessTokenUseCase.getSocialAccessToken(socialType);

      if (socialToken == null) return onError('인증이 취소되었습니다.');

      onSuccess(socialToken);
    } catch (e) {
      logger.e(e);
      onError('인증 진행 중 문제가 발생하였습니다.');
    }
  }

  Future<void> withdrawal(String socialAccessToken, RevokeType revokeType, String? reason) async {
    await withdrawalUseCase.withdrawal(
      socialAccessToken: socialAccessToken,
      revokeType: revokeType,
      reason: reason,
    );
  }
}
