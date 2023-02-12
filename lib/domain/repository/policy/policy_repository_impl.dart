import 'package:bookand/data/datasource/remote/policy/policy_remote_data_source.dart';
import 'package:bookand/data/datasource/remote/policy/policy_remote_data_source_impl.dart';
import 'package:bookand/domain/model/policy_model.dart';
import 'package:bookand/domain/repository/policy/policy_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'policy_repository_impl.g.dart';

@riverpod
PolicyRepository policyRepository(PolicyRepositoryRef ref) {
  final policyRemoteDataSource = ref.read(policyRemoteDataSourceProvider);

  return PolicyRepositoryImpl(policyRemoteDataSource);
}

class PolicyRepositoryImpl implements PolicyRepository {
  final PolicyRemoteDataSource policyRemoteDataSource;

  PolicyRepositoryImpl(this.policyRemoteDataSource);

  @override
  Future<PolicyModel> getPolicy(String terms) async {
    final policyEntity = await policyRemoteDataSource.getPolicy(terms);

    return PolicyModel(policyEntity.title, policyEntity.content);
  }
}
