import 'dart:async';

import 'package:bookand/core/error/user_not_found_exception.dart';
import 'package:bookand/domain/repository/auth_repository.dart';
import 'package:bookand/data/repository/auth_repository_impl.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../core/const/social_type.dart';
import '../../core/const/storage_key.dart';
import '../../core/util/logger.dart';

part 'login_use_case.g.dart';

@riverpod
LoginUseCase loginUseCase(LoginUseCaseRef ref) {
  final authRepository = ref.read(authRepositoryProvider);
  const storage = FlutterSecureStorage();

  return LoginUseCase(authRepository, storage);
}

class LoginUseCase {
  final AuthRepository authRepository;
  final FlutterSecureStorage storage;

  LoginUseCase(this.authRepository, this.storage);

  Future<void> login({
    required SocialType socialType,
    required Function() onSuccess,
    required Function() onCancel,
    required Function(String signToken) onSignUp,
  }) async {
    try {
      final accessToken = await getSocialAccessToken(socialType);

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

  Future<String?> getSocialAccessToken(SocialType type) async {
    final completer = Completer<String?>();

    switch (type) {
      case SocialType.NONE:
        completer.complete(null);
        break;
      case SocialType.GOOGLE:
        final googleSignIn = GoogleSignIn();
        final account = await googleSignIn.signIn();
        final auth = await account?.authentication;
        completer.complete(auth?.accessToken);
        break;
      case SocialType.APPLE:
        final credential = await SignInWithApple.getAppleIDCredential(
          scopes: [
            AppleIDAuthorizationScopes.email,
            AppleIDAuthorizationScopes.fullName,
          ],
        );
        completer.complete(credential.identityToken);
        break;
    }

    return completer.future;
  }
}
