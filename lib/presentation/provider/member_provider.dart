import 'package:bookand/core/app_strings.dart';
import 'package:bookand/core/const/revoke_type.dart';
import 'package:bookand/domain/usecase/fcm_use_case.dart';
import 'package:bookand/domain/usecase/get_social_login_use_case.dart';
import 'package:bookand/domain/usecase/login_use_case.dart';
import 'package:bookand/domain/usecase/logout_use_case.dart';
import 'package:bookand/domain/usecase/sign_up_use_case.dart';
import 'package:bookand/domain/usecase/withdrawal_use_case.dart';
import 'package:bookand/presentation/provider/auth_provider.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/const/auth_state.dart';
import '../../core/const/remote_config_key.dart';
import '../../core/const/social_type.dart';
import '../../core/util/common_util.dart';
import '../../core/util/logger.dart';
import '../../data/repository/member_repository_impl.dart';
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
      final packageInfo = await PackageInfo.fromPlatform();
      final serverVersion = FirebaseRemoteConfig.instance.getString(RemoteConfigKey.serverVersion);

      logger.i('앱 버전: ${packageInfo.version}\n서버 버전: $serverVersion');
      if (CommonUtil.checkRequiredUpdate(packageInfo.version, serverVersion)) {
        authState.changeState(AuthState.update);
        return;
      }

      state = await memberRepository.getMe();
      authState.changeState(AuthState.signIn);
      ref.read(fcmUseCaseProvider).refreshFCMToken();
    } catch (e) {
      logger.e('사용자 정보를 가져오는데 실패', e);
      authState.changeState(AuthState.init);
    } finally {
      FlutterNativeSplash.remove();
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
          onSignUp: () {
            authState.changeState(AuthState.signUp);
          });
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
