import 'package:bookand/data/repository/policy_repository_impl.dart';
import 'package:bookand/domain/repository/policy_repository.dart';
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

  void fetchAllPolicy() async {
    await Future.wait({
      repository.getPolicy(Policy.terms),
      repository.getPolicy(Policy.personalInfoAgree),
      repository.getPolicy(Policy.locationBaseTerms),
      repository.getPolicy(Policy.privacy),
      repository.getPolicy(Policy.operation),
    });
  }

  Future<PolicyModel> getPolicy(Policy policy) async {
    return await repository.getPolicy(policy);
  }
}
