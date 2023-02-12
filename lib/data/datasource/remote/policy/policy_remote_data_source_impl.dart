import 'dart:async';

import 'package:bookand/data/datasource/remote/policy/policy_remote_data_source.dart';
import 'package:bookand/data/entity/policy_entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../api/policy_api.dart';

part 'policy_remote_data_source_impl.g.dart';

@riverpod
PolicyRemoteDataSource policyRemoteDataSource(PolicyRemoteDataSourceRef ref) {
  final policyApi = ref.read(policyApiProvider);

  return PolicyRemoteDataSourceImpl(policyApi);
}

class PolicyRemoteDataSourceImpl implements PolicyRemoteDataSource {
  final PolicyApi api;

  PolicyRemoteDataSourceImpl(this.api);

  @override
  Future<PolicyEntity> getPolicy(String terms) async {
    final completer = Completer<PolicyEntity>();

    try {
      final resp = await api.getPolicy(terms);
      completer.complete(resp);
    } catch (e) {
      completer.completeError(e);
    }

    return completer.future;
  }
}
