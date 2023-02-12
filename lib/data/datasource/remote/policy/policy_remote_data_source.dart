import '../../../entity/policy_entity.dart';

abstract class PolicyRemoteDataSource {
  Future<PolicyEntity> getPolicy(String terms);
}
