import '../../core/const/policy.dart';
import '../model/policy_model.dart';

abstract class PolicyRepository {
  Future<void> putPolicy(Policy policy, PolicyModel policyModel);
  Future<PolicyModel> getPolicy(Policy policy);
}
