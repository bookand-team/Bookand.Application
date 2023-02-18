import 'dart:async';
import 'dart:convert';

import 'package:bookand/data/datasource/remote/policy/policy_remote_data_source.dart';
import 'package:bookand/data/entity/policy_entity.dart';
import 'package:bookand/data/service/policy/policy_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

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
  Future<PolicyEntity> getPolicy(String policyName) async {
    final resp = await service.getPolicy(policyName);
    final data = PolicyEntity.fromJson(jsonDecode(resp.bodyString));

    if (resp.isSuccessful) {
      return data;
    } else {
      throw resp;
    }
  }
}
