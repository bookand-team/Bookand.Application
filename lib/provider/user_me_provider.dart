import 'dart:async';
import 'dart:io';

import 'package:bookand/config/app_config.dart';
import 'package:dio/dio.dart';
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
    try {
      final refreshToken = await storage.read(key: refreshTokenKey);
      final accessToken = await storage.read(key: accessTokenKey);

      if (refreshToken == null || accessToken == null) {
        state = UserModelInit();
        return;
      }

      final resp = await repository.getMe();

      state = resp;
    } catch (e) {
      logger.e(e);

      state = UserModelError(message: '로그인에 실패했습니다.');
    }
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
        login(socialToken: socialToken);
      }
    } catch (e) {
      logger.e(e);

      var errMsg = '구글 로그인에 실패했습니다.';

      if (AppConfig.appMode == AppMode.dev) {
        errMsg += '\n${e.toString()}';
      }

      onError(errMsg);
    }
  }

  void appleLogin({required Function(String) onError}) async {
    state = UserModelLoading();
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      if (credential.identityToken == null) {
        onError('애플 로그인이 취소되었습니다.');
      } else {
        socialToken = SocialToken(credential.identityToken!, SocialType.apple);
        login(socialToken: socialToken);
      }
    } catch (e) {
      logger.e(e);

      var errMsg = '애플 로그인에 실패했습니다.';

      if (AppConfig.appMode == AppMode.dev) {
        errMsg += '\n${e.toString()}';
      }

      onError(errMsg);
    }
  }

  void login({required SocialToken socialToken}) async {
    state = UserModelLoading();

    try {
      final resp = await authRepository.fetchLogin(
          accessToken: socialToken.token, socialType: socialToken.socialType);

      await storage.write(key: refreshTokenKey, value: resp.refreshToken);
      await storage.write(key: accessTokenKey, value: resp.accessToken);

      getMe();
    } on DioError catch (e) {
      logger.e(e);
      if (e.response?.statusCode == HttpStatus.notFound) {
        state = UserModelSignUp();
      } else {
        rethrow;
      }
    }
  }

  void logout() async {
    try {
      final accessToken = await storage.read(key: accessTokenKey);
      authRepository.logout(accessToken!);
    } catch (e) {
      logger.e(e);
    } finally {
      state = UserModelInit();
      await Future.wait([
        storage.delete(key: refreshTokenKey),
        storage.delete(key: accessTokenKey),
      ]);
    }
  }

  Future<void> refreshToken() async {
    await authRepository.refreshToken();
  }

  void cancelSignUp() {
    state = UserModelInit();
  }
}
