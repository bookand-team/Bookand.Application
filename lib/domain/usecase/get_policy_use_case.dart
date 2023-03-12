import 'package:bookand/core/const/hive_key.dart';
import 'package:bookand/data/repository/policy_repository_impl.dart';
import 'package:bookand/domain/repository/policy_repository.dart';
import 'package:hive/hive.dart';
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
    final policyList = await Future.wait({
      repository.getPolicy(Policy.terms.name),
      repository.getPolicy(Policy.personalInfoAgree.name),
      repository.getPolicy(Policy.locationBaseTerms.name),
      repository.getPolicy(Policy.privacy.name),
      repository.getPolicy(Policy.operation.name),
    });

    final box = Hive.box(HiveKey.policyBoxKey);

    box.put(HiveKey.policyKey, policyList);
  }

  Future<PolicyModel> getPolicy(Policy policy) async {
    return await repository.getPolicy(policy.name);
  }
}
