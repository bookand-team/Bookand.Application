import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/const/revoke_type.dart';
import '../../data/repository/member_repository_impl.dart';
import '../repository/member_repository.dart';

part 'withdrawal_use_case.g.dart';

@riverpod
WithdrawalUseCase withdrawalUseCase(WithdrawalUseCaseRef ref) {
  final repository = ref.read(memberRepositoryProvider);

  return WithdrawalUseCase(repository);
}

class WithdrawalUseCase {
  final MemberRepository repository;

  WithdrawalUseCase(this.repository);

  Future<void> withdrawal({
    required String socialAccessToken,
    required RevokeType revokeType,
    String? reason,
  }) async {
    try {
      await repository.revoke(socialAccessToken, revokeType, reason);
    } catch (_) {
      rethrow;
    }
  }
}
