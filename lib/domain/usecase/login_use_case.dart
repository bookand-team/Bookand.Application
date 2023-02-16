import 'dart:convert';

import 'package:bookand/domain/repository/auth/auth_repository.dart';
import 'package:bookand/domain/repository/auth/auth_repository_impl.dart';
import 'package:chopper/chopper.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/const/social_type.dart';
import '../../core/const/storage_key.dart';

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
    required String accessToken,
    required SocialType socialType,
    required Function() onSuccess,
    required Function() onSignUp,
  }) async {
    try {
      final token = await authRepository.login(accessToken, socialType);

      await storage.write(key: refreshTokenKey, value: token.refreshToken);
      await storage.write(key: accessTokenKey, value: token.accessToken);
      onSuccess();
    } catch (e) {
      if (e is Response) {
        final jsonData = jsonDecode(e.bodyString);
        final signToken = jsonData['signToken'];
        await storage.write(key: signTokenKey, value: signToken);
        onSignUp();
      } else {
        throw (e.toString());
      }
    }
  }
}
