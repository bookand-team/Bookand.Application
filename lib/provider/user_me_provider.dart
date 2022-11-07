import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../const/social_type.dart';
import '../const/storage_key.dart';
import '../data/model/social_token.dart';
import '../util/logger.dart';
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

  void googleLogin() async {
    state = UserModelLoading();
    try {
      final googleSignIn = GoogleSignIn();
      final account = await googleSignIn.signIn();
      final auth = await account?.authentication;
      final accessToken = auth?.accessToken;

      if (accessToken == null) {
        state = UserModelError(message: '구글 로그인이 취소되었습니다.');
      } else {
        socialToken = SocialToken(accessToken, SocialType.google);
        // TODO: 신규 유저 체크
        /// 신규 유저인 경우 state = UserModelSignUp()
        /// 신규 유저가 아닌 경우 로그인 요청
        state = UserModelSignUp();
      }
    } catch (e) {
      state = UserModelError(message: '구글 로그인에 실패했습니다.');
    }
  }

  void login({required SocialToken socialToken}) async {
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

      state = UserModelError(message: '$type 로그인에 실패했습니다.');
    }
  }

  Future<void> logout() async {
    state = UserModelInit();

    final accessToken = await storage.read(key: accessTokenKey);
    authRepository.logout(accessToken!);
    await Future.wait([storage.delete(key: refreshTokenKey), storage.delete(key: accessTokenKey)]);
  }

  void cancelSignUp() {
    state = UserModelInit();
  }
}
