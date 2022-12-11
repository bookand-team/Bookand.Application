import 'dart:async';

import 'package:bookand/config/app_config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../common/const/app_mode.dart';
import '../common/const/social_type.dart';
import '../common/const/storage_key.dart';
import '../common/util/logger.dart';
import '../data/model/social_token.dart';
import 'secure_storage_provider.dart';
import '../data/model/user_model.dart';
import '../data/repository/auth_repository.dart';
import '../data/repository/user_me_repository.dart';

final userMeProvider = StateNotifierProvider<UserMeStateNotifier, UserModelBase>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  final userMeRepository = ref.watch(userMeRepositoryProvider);
  final storage = ref.watch(secureStorageProvider);

  return UserMeStateNotifier(
      authRepository: authRepository, repository: userMeRepository, storage: storage);
});

class UserMeStateNotifier extends StateNotifier<UserModelBase> {
  final AuthRepository authRepository;
  final UserMeRepository repository;
  final FlutterSecureStorage storage;
  late SocialToken socialToken;

  UserMeStateNotifier(
      {required this.authRepository, required this.repository, required this.storage})
      : super(UserModelLoading()) {
    getMe();
  }

  void getMe() async {
    final refreshToken = await storage.read(key: refreshTokenKey);
    final accessToken = await storage.read(key: accessTokenKey);

    if (refreshToken == null || accessToken == null) {
      state = UserModelInit();
      return;
    }

    final respData = await repository.getMe();
    final resp = UserModel.fromJson(respData.data);

    state = resp;
  }

  void googleLogin({required Function(String) onError}) async {
    state = UserModelLoading();
    try {
      final googleSignIn = GoogleSignIn();
      final account = await googleSignIn.signIn();
      final auth = await account?.authentication;
      final googleAccessToken = auth?.accessToken;

      if (googleAccessToken == null) {
        onError('구글 로그인이 취소되었습니다.');
      } else {
        socialToken = SocialToken(googleAccessToken, SocialType.google);
        // TODO: 신규 유저 체크
        /// 신규 유저인 경우 state = UserModelSignUp()
        /// 신규 유저가 아닌 경우 로그인 요청
        state = UserModelSignUp();
      }
    } catch (e) {
      logger.e(e);
      onError('구글 로그인에 실패했습니다.');
    }
  }

  void appleLogin({required Function(String) onError}) async {
    final credential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      webAuthenticationOptions: WebAuthenticationOptions(
        clientId: "Apple Developer 에서 설정한 Service ID",
        redirectUri: Uri.parse(
          "Apple Developer 에서 설정한 redirectUri",
        ),
      ),
    );

    logger.d(credential);

    // state = UserModelLoading();
    // try {
    //   final appleSignIn = SignInWithApple();
    //   appleSignIn.
    //
    //   if (accessToken == null) {
    //     state = UserModelError(message: '애플 로그인이 취소되었습니다.');
    //   } else {
    //     socialToken = SocialToken(accessToken, SocialType.apple);
    //     // TODO: 신규 유저 체크
    //     /// 신규 유저인 경우 state = UserModelSignUp()
    //     /// 신규 유저가 아닌 경우 로그인 요청
    //     state = UserModelSignUp();
    //   }
    // } catch (e) {
    //   state = UserModelError(message: '애플 로그인에 실패했습니다.');
    // }
  }

  void login({required SocialToken socialToken, required Function(String) onError}) async {
    try {
      state = UserModelLoading();

      final resp = await authRepository.fetchLogin(
          accessToken: socialToken.token, socialType: socialToken.socialType);

      await storage.write(key: refreshTokenKey, value: resp.refreshToken);
      await storage.write(key: accessTokenKey, value: resp.accessToken);

      final respData = await repository.getMe();
      final userResp = UserModel.fromJson(respData.data);

      state = userResp;
    } catch (e) {
      state = UserModelError();
      logger.e(e);
      var type = '';

      switch (socialToken.socialType) {
        case SocialType.google:
          type = '구글';
          break;
        case SocialType.apple:
          type = '애플';
          break;
      }

      var popUpMsg = '$type 로그인에 실패했습니다.';

      if (AppConfig.appMode == AppMode.dev) {
        popUpMsg += '\n에러: ${e.toString()}';
      }

      onError(popUpMsg);
    }
  }

  Future<void> logout() async {
    state = UserModelInit();

    final accessToken = await storage.read(key: accessTokenKey);
    authRepository.logout(accessToken!);
    await Future.wait([storage.delete(key: refreshTokenKey), storage.delete(key: accessTokenKey)]);
  }

  Future<void> refreshToken() async {
    await authRepository.refreshToken();
  }

  void cancelSignUp() {
    state = UserModelInit();
  }
}
