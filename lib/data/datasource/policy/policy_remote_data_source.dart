import 'package:bookand/domain/model/policy_model.dart';

abstract class PolicyRemoteDataSource {
  Future<PolicyModel> getPolicy(String policyName);
}
