import '../model/policy_model.dart';

abstract class PolicyRepository {
  Future<PolicyModel> getPolicy(String terms);
}
