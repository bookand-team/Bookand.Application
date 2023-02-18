import 'package:bookand/domain/repository/auth_repository.dart';
import 'package:bookand/data/repository/auth/auth_repository_impl.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/app_strings.dart';
import '../../core/const/storage_key.dart';

part 'sign_up_use_case.g.dart';

@riverpod
SignUpUseCase signUpUseCase(SignUpUseCaseRef ref) {
  final repository = ref.read(authRepositoryProvider);
  const storage = FlutterSecureStorage();

  return SignUpUseCase(repository, storage);
}

class SignUpUseCase {
  final AuthRepository repository;
  final FlutterSecureStorage storage;

  SignUpUseCase(this.repository, this.storage);

  Future<void> signUp() async {
    final signToken = await storage.read(key: signTokenKey);

    if (signToken == null) {
      throw (AppStrings.signTokenNotFound);
    }

    final token = await repository.signUp(signToken);

    await storage.write(key: refreshTokenKey, value: token.refreshToken);
    await storage.write(key: accessTokenKey, value: token.accessToken);
  }
}
