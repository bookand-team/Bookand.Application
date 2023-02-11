import 'dart:io';

import 'package:bookand/data/api/auth_api.dart';
import 'package:bookand/data/api/user_api.dart';
import 'package:bookand/data/api_helper.dart';
import 'package:bookand/data/datasource/remote/auth_remote_data_source_impl.dart';
import 'package:bookand/data/datasource/remote/user_remote_data_source_impl.dart';
import 'package:bookand/presentation/provider/secure_storage_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../core/config/app_config.dart';
import '../../core/const/social_type.dart';
import '../../core/const/storage_key.dart';
import '../../core/util/logger.dart';
import '../../data/datasource/remote/auth_remote_data_source.dart';
import '../../data/datasource/remote/user_remote_data_source.dart';
import '../../data/model/auth/social_token.dart';
import '../../data/model/member/member_model.dart';

final userMeProvider = StateNotifierProvider<UserMeStateNotifier, MemberModelBase>((ref) {
  final authRemoteDataSource = AuthRemoteDataSourceImpl(AuthApi(
    ApiHelper.create(),
    baseUrl: AppConfig.instance.baseUrl,
  ));
  final userRemoteDataSource = UserRemoteDataSourceImpl(UserApi(
    ApiHelper.create(),
    baseUrl: AppConfig.instance.baseUrl,
  ));
  final storage = ref.watch(secureStorageProvider);

  return UserMeStateNotifier(
      authRemoteDataSource: authRemoteDataSource,
      userRemoteDataSource: userRemoteDataSource,
      storage: storage);
});

class UserMeStateNotifier extends StateNotifier<MemberModelBase> {
  final AuthRemoteDataSource authRemoteDataSource;
  final UserRemoteDataSource userRemoteDataSource;
  final FlutterSecureStorage storage;
  late SocialToken socialToken;

  UserMeStateNotifier({
    required this.authRemoteDataSource,
    required this.userRemoteDataSource,
    required this.storage,
  }) : super(MemberModelLoading()) {
    getMe();
  }

  void getMe() async {
    try {
      final refreshToken = await storage.read(key: refreshTokenKey);
      final accessToken = await storage.read(key: accessTokenKey);

      if (refreshToken == null || accessToken == null) {
        state = MemberModelInit();
        return;
      }

      final resp = await userRemoteDataSource.getMe(accessToken);

      state = resp;
    } catch (e) {
      logger.e(e);
      state = MemberModelInit();
    }
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
        onError('구글 로그인이 취소되었습니다.');
      } else {
        socialToken = SocialToken(googleAccessToken, SocialType.google);
        login(socialToken: socialToken).onError((DioError e, _) {
          onError('로그인 중 문제가 발생하였습니다.\n에러: ${e.response?.data['code'] ?? e.error}');
        });
      }
    } catch (e) {
      logger.e(e);
      state = MemberModelError();
      onError('구글 로그인에 실패했습니다.');
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
        onError('애플 로그인이 취소되었습니다.');
      } else {
        socialToken = SocialToken(credential.identityToken!, SocialType.apple);
        login(socialToken: socialToken).onError((DioError e, _) {
          onError('로그인 중 문제가 발생하였습니다.\n에러: ${e.response?.data['code'] ?? e.error}');
        });
      }
    } catch (e) {
      logger.e(e);
      onError('애플 로그인에 실패했습니다.');
    }
  }

  Future<void> login({required SocialToken socialToken}) async {
    state = MemberModelLoading();

    try {
      final resp = await authRemoteDataSource.login(socialToken);

      await storage.write(key: refreshTokenKey, value: resp.refreshToken);
      await storage.write(key: accessTokenKey, value: resp.accessToken);

      getMe();
    } on DioError catch (e) {
      logger.e(e.message);
      if (e.response?.statusCode == HttpStatus.notFound) {
        final signToken = e.response?.data['signToken'];
        await storage.write(key: signTokenKey, value: signToken);
        state = MemberModelSignUp();
      } else {
        state = MemberModelError();
        return Future.error(e);
      }
    } catch (e) {
      state = MemberModelError();
      return Future.error(e);
    }
  }

  Future<void> signUp() async {
    state = MemberModelLoading();

    try {
      final signToken = await storage.read(key: signTokenKey);
      final resp = await authRemoteDataSource.signUp(signToken!);

      await storage.write(key: refreshTokenKey, value: resp.refreshToken);
      await storage.write(key: accessTokenKey, value: resp.accessToken);

      getMe();
    } catch (e) {
      state = MemberModelError();
      return Future.error(e);
    }
  }

  void logout() async {
    try {
      final accessToken = await storage.read(key: accessTokenKey);
      authRemoteDataSource.logout(accessToken!);
    } catch (e) {
      logger.e(e);
    } finally {
      state = MemberModelInit();
      await Future.wait([
        storage.delete(key: refreshTokenKey),
        storage.delete(key: accessTokenKey),
      ]);
    }
  }

  void cancelSignUp() {
    state = MemberModelInit();
  }
}
