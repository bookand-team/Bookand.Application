import 'package:bookand/core/const/policy.dart';
import 'package:bookand/data/datasource/policy/policy_local_data_source.dart';
import 'package:bookand/data/datasource/policy/policy_local_data_source_impl.dart';
import 'package:bookand/domain/model/policy_model.dart';
import 'package:bookand/domain/repository/policy_repository.dart';
import 'package:chopper/chopper.dart';
import 'package:hive/hive.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/util/logger.dart';
import '../../core/util/utf8_util.dart';
import '../../domain/model/error_response.dart';
import '../datasource/policy/policy_remote_data_source.dart';
import '../datasource/policy/policy_remote_data_source_impl.dart';

part 'policy_repository_impl.g.dart';

@riverpod
PolicyRepository policyRepository(PolicyRepositoryRef ref) {
  final policyRemoteDataSource = ref.read(policyRemoteDataSourceProvider);
  final policyLocalDataSource = ref.read(policyLocalDataSourceProvider);

  return PolicyRepositoryImpl(policyRemoteDataSource, policyLocalDataSource);
}

class PolicyRepositoryImpl implements PolicyRepository {
  final PolicyRemoteDataSource policyRemoteDataSource;
  final PolicyLocalDataSource policyLocalDataSource;

  PolicyRepositoryImpl(this.policyRemoteDataSource, this.policyLocalDataSource);

  @override
  Future<void> putPolicy(Policy policy, PolicyModel policyModel) async {
    await policyLocalDataSource.putPolicy(policy, policyModel);
  }

  @override
  Future<PolicyModel> getPolicy(Policy policy) async {
    try {
      return await policyLocalDataSource.getPolicy(policy);
    } on HiveError {
      final policyModel = await policyRemoteDataSource.getPolicy(policy.name);
      policyLocalDataSource.putPolicy(policy, policyModel);
      return policyModel;
    } on Response catch (e) {
      throw ErrorResponse.fromJson(Utf8Util.utf8JsonDecode(e.bodyString));
    } catch (e) {
      logger.e(e.toString());
      rethrow;
    }
  }
}
