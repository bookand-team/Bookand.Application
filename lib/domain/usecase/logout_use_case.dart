import 'package:bookand/domain/repository/auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/util/logger.dart';
import '../../data/repository/auth_repository_impl.dart';

part 'logout_use_case.g.dart';

@riverpod
LogoutUseCase logoutUseCase(LogoutUseCaseRef ref) {
  final repository = ref.read(authRepositoryProvider);
  return LogoutUseCase(repository);
}

class LogoutUseCase {
  final AuthRepository repository;

  LogoutUseCase(this.repository);

  Future<void> logout() async {
    try {
      await repository.logout();
    } catch (e) {
      logger.e(e);
    }
  }
}
