import 'package:bookand/domain/repository/auth/auth_repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/const/storage_key.dart';
import '../../core/util/logger.dart';
import '../repository/auth/auth_repository_impl.dart';

part 'logout_use_case.g.dart';

@riverpod
LogoutUseCase logoutUseCase(LogoutUseCaseRef ref) {
  final repository = ref.read(authRepositoryProvider);
  const storage = FlutterSecureStorage();

  return LogoutUseCase(repository, storage);
}

class LogoutUseCase {
  final AuthRepository repository;
  final FlutterSecureStorage storage;

  LogoutUseCase(this.repository, this.storage);

  Future<void> logout({required Function() onFinish}) async {
    try {
      final accessToken = await storage.read(key: accessTokenKey);
      await repository.logout(accessToken!);
    } catch (e) {
      logger.e(e);
    } finally {
      await Future.wait([
        storage.delete(key: refreshTokenKey),
        storage.delete(key: accessTokenKey),
      ]);
      onFinish();
    }
  }
}
