import 'package:bookand/domain/model/policy_model.dart';

abstract interface class PolicyRemoteDataSource {
  Future<PolicyModel> getPolicy(String policyName);
}
