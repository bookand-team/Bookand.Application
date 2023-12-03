import 'dart:async';

import 'package:bookand/core/error/user_not_found_exception.dart';
import 'package:bookand/data/repository/auth_repository_impl.dart';
import 'package:bookand/domain/repository/auth_repository.dart';
import 'package:bookand/domain/usecase/get_social_login_use_case.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/const/social_type.dart';
import '../../core/util/logger.dart';

part 'login_use_case.g.dart';

@riverpod
LoginUseCase loginUseCase(LoginUseCaseRef ref) {
  final authRepository = ref.read(authRepositoryProvider);
  final getSocialAccessTokenUseCase = ref.read(getSocialAccessTokenUseCaseProvider);
  return LoginUseCase(authRepository, getSocialAccessTokenUseCase);
}

class LoginUseCase {
  final AuthRepository authRepository;
  final GetSocialAccessTokenUseCase getSocialAccessTokenUseCase;

  LoginUseCase(this.authRepository, this.getSocialAccessTokenUseCase);

  Future<void> login({
    required SocialType socialType,
    required Function() onSuccess,
    required Function() onCancel,
    required Function() onSignUp,
  }) async {
    try {
      final socialAccessToken = await getSocialAccessTokenUseCase.getSocialAccessToken(socialType);

      if (socialAccessToken == null) {
        return onCancel();
      }

      await authRepository.login(socialAccessToken, socialType);
      onSuccess();
    } on UserNotFoundException catch (e) {
      logger.i(e.message);
      onSignUp();
    } catch (_) {
      rethrow;
    }
  }
}
