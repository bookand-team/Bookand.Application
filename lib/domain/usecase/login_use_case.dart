import 'dart:async';

import 'package:bookand/core/error/user_not_found_exception.dart';
import 'package:bookand/domain/usecase/get_social_login_use_case.dart';
import 'package:bookand/domain/repository/auth_repository.dart';
import 'package:bookand/data/repository/auth_repository_impl.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/const/social_type.dart';
import '../../core/const/storage_key.dart';
import '../../core/util/logger.dart';

part 'login_use_case.g.dart';

@riverpod
LoginUseCase loginUseCase(LoginUseCaseRef ref) {
  final authRepository = ref.read(authRepositoryProvider);
  final getSocialAccessTokenUseCase = ref.read(getSocialAccessTokenUseCaseProvider);
  const storage = FlutterSecureStorage();

  return LoginUseCase(authRepository, getSocialAccessTokenUseCase, storage);
}

class LoginUseCase {
  final AuthRepository authRepository;
  final GetSocialAccessTokenUseCase getSocialAccessTokenUseCase;
  final FlutterSecureStorage storage;

  LoginUseCase(this.authRepository, this.getSocialAccessTokenUseCase, this.storage);

  Future<void> login({
    required SocialType socialType,
    required Function() onSuccess,
    required Function() onCancel,
    required Function(String signToken) onSignUp,
  }) async {
    try {
      final accessToken = await getSocialAccessTokenUseCase.getSocialAccessToken(socialType);

      if (accessToken == null) {
        return onCancel();
      }

      final token = await authRepository.login(accessToken, socialType);

      await storage.write(key: refreshTokenKey, value: token.refreshToken);
      await storage.write(key: accessTokenKey, value: token.accessToken);
      onSuccess();
    } on UserNotFoundException catch (e) {
      logger.i(e.message);
      onSignUp(e.signToken);
    } catch (e) {
      throw (e.toString());
    }
  }
}
