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

final userMeProvider = StateNotifierProvider<UserMeStateNotifier, UserModelBase?>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  final userMeRepository = ref.watch(userMeRepositoryProvider);
  final storage = ref.watch(secureStorageProvider);

  return UserMeStateNotifier(
      authRepository: authRepository, repository: userMeRepository, storage: storage);
});

class UserMeStateNotifier extends StateNotifier<UserModelBase?> {
  final AuthRepository authRepository;
  final UserMeRepository repository;
  final FlutterSecureStorage storage;

  bool isSigned = false;
  bool isLoading = false;

  UserMeStateNotifier(
      {required this.authRepository, required this.repository, required this.storage})
      : super(UserModelLoading()) {
    getMe();
  }

  Future<void> getMe() async {
    final refreshToken = await storage.read(key: refreshTokenKey);
    final accessToken = await storage.read(key: accessTokenKey);

    if (refreshToken == null || accessToken == null) {
      state = null;
      return;
    }

    final respData = await repository.getMe();
    final resp = UserModel.fromJson(respData.data);

    state = resp;
  }

  Future<void> login({required String accessToken, required SocialType socialType}) async {
    try {
      isLoading = true;
      state = UserModelLoading();

      final resp =
          await authRepository.fetchLogin(accessToken: accessToken, socialType: socialType);

      await storage.write(key: refreshTokenKey, value: resp.refreshToken);
      await storage.write(key: accessTokenKey, value: resp.accessToken);

      final respData = await repository.getMe();
      final userResp = UserModel.fromJson(respData.data);

      state = userResp;
    } catch (e) {
      logger.e(e);
      var type = '';

      switch (socialType) {
        case SocialType.google:
          type = '구글';
          break;
        case SocialType.apple:
          type = '애플';
          break;
      }

      state = UserModelError(message: '$type 로그인에 실패했습니다.');
    } finally {
      isLoading = false;
    }
  }

  Future<SocialTokenBase> googleLogin() async {
    final completer = Completer<SocialTokenBase>();
    try {
      isLoading = true;
      final googleSignIn = GoogleSignIn();
      final account = await googleSignIn.signIn();
      final auth = await account?.authentication;
      final accessToken = auth?.accessToken;

      if (accessToken == null) {
        completer.completeError(SocialTokenError(message: '구글 로그인이 취소되었습니다.'));
      } else {
        // TODO: 가입자 여부에 따라 약관 동의 페이지와 홈 페이지로 분기
        /// 가입자가 아닌 경우 state = null 처리 후 약관 동의 페이지로 이동
        /// 가입자인 경우 로그인 요청 후 state에 유저 정보 저장 후 홈 페이지로 이동
        completer.complete(SocialToken(accessToken, SocialType.google));
      }
    } catch (e) {
      completer.completeError(SocialTokenError(message: '구글 로그인에 실패했습니다.'));
    } finally {
      isLoading = false;
    }

    return completer.future;
  }

  Future<void> logout() async {
    state = null;

    final accessToken = await storage.read(key: accessTokenKey);
    authRepository.logout(accessToken!);
    await Future.wait([storage.delete(key: refreshTokenKey), storage.delete(key: accessTokenKey)]);
  }
}
