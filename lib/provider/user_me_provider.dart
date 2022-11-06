import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../const/social_type.dart';
import '../const/storage_key.dart';
import 'secure_storage_provider.dart';
import '../data/model/user_model.dart';
import '../data/repository/auth_repository.dart';
import '../data/repository/user_me_repository.dart';
import '../util/logger.dart';

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

    final resp = await repository.getMe();

    state = resp;
  }

  Future<UserModelBase> login({required String accessToken, required SocialType socialType}) async {
    try {
      state = UserModelLoading();

      final resp =
          await authRepository.fetchLogin(accessToken: accessToken, socialType: socialType);

      await storage.write(key: refreshTokenKey, value: resp.refreshToken);
      await storage.write(key: accessTokenKey, value: resp.accessToken);

      final userResp = await repository.getMe();

      state = userResp;

      return userResp;
    } catch (e) {
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

      return Future.value(state);
    }
  }

  void googleLogin() async {
    state = UserModelLoading();

    try {
      final googleSignIn = GoogleSignIn();
      final account = await googleSignIn.signIn();
      final auth = await account?.authentication;
      final accessToken = auth?.accessToken;

      if (accessToken == null) {
        logger.i('사용자에 의해 로그인이 취소됨.');
        state = UserModelError(message: '구글 로그인이 취소되었습니다.');
        return;
      }

      await login(accessToken: accessToken, socialType: SocialType.google);
    } catch (e) {
      logger.e(e.toString());
      state = UserModelError(message: '구글 로그인에 실패했습니다.');
    }
  }

  Future<void> logout() async {
    state = null;

    final accessToken = await storage.read(key: accessTokenKey);
    authRepository.logout(accessToken!);
    await Future.wait([storage.delete(key: refreshTokenKey), storage.delete(key: accessTokenKey)]);
  }
}
