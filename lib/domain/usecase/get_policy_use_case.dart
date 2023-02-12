import 'package:bookand/domain/repository/policy/policy_repository.dart';
import 'package:bookand/domain/repository/policy/policy_repository_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/const/policy.dart';
import '../model/policy_model.dart';

part 'get_policy_use_case.g.dart';

@riverpod
GetPolicyUseCase getPolicyUseCase(GetPolicyUseCaseRef ref) {
  final repository = ref.read(policyRepositoryProvider);

  return GetPolicyUseCase(repository);
}

class GetPolicyUseCase {
  final PolicyRepository repository;

  GetPolicyUseCase(this.repository);

  Future<PolicyModel> getPolicy(Policy policy) async {
    return await repository.getPolicy(policy.name);
  }
}
