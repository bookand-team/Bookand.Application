import 'package:bookand/core/const/storage_key.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/const/revoke_type.dart';
import '../../data/repository/member_repository_impl.dart';
import '../repository/member_repository.dart';

part 'withdrawal_use_case.g.dart';

@riverpod
WithdrawalUseCase withdrawalUseCase(WithdrawalUseCaseRef ref) {
  final repository = ref.read(memberRepositoryProvider);
  const storage = FlutterSecureStorage();

  return WithdrawalUseCase(repository, storage);
}

class WithdrawalUseCase {
  final MemberRepository repository;
  final FlutterSecureStorage storage;

  WithdrawalUseCase(this.repository, this.storage);

  Future<void> withdrawal({
    required String socialAccessToken,
    required RevokeType revokeType,
    String? reason,
  }) async {
    final accessToken = await storage.read(key: accessTokenKey);

    try {
      await repository.revoke(accessToken!, socialAccessToken, revokeType, reason);
    } catch (_) {
      rethrow;
    }
  }
}
