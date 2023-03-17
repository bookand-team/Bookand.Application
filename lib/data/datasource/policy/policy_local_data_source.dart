import '../../../core/const/policy.dart';
import '../../../domain/model/policy_model.dart';

abstract class PolicyLocalDataSource {
  Future<void> putPolicy(Policy policy, PolicyModel policyModel);
  Future<PolicyModel> getPolicy(Policy policy);
}
