import 'dart:async';

import 'package:bookand/data/datasource/policy/policy_remote_data_source.dart';
import 'package:bookand/domain/model/policy_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/util/utf8_util.dart';
import '../../service/policy_service.dart';

part 'policy_remote_data_source_impl.g.dart';

@riverpod
PolicyRemoteDataSource policyRemoteDataSource(PolicyRemoteDataSourceRef ref) {
  final policyService = ref.read(policyServiceProvider);

  return PolicyRemoteDataSourceImpl(policyService);
}

class PolicyRemoteDataSourceImpl implements PolicyRemoteDataSource {
  final PolicyService service;

  PolicyRemoteDataSourceImpl(this.service);

  @override
  Future<PolicyModel> getPolicy(String policyName) async {
    final resp = await service.getPolicy(policyName);

    if (resp.isSuccessful) {
      return PolicyModel.fromJson(Utf8Util.utf8JsonDecode(resp.bodyString));
    } else {
      throw resp;
    }
  }
}
