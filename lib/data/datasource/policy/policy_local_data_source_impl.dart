import 'dart:async';

import 'package:bookand/core/const/hive_key.dart';
import 'package:bookand/core/const/policy.dart';
import 'package:bookand/data/datasource/policy/policy_local_data_source.dart';
import 'package:bookand/domain/model/policy_model.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'policy_local_data_source_impl.g.dart';

@riverpod
PolicyLocalDataSource policyLocalDataSource(PolicyLocalDataSourceRef ref) {
  final box = Hive.box(HiveKey.policyBoxKey);

  return PolicyLocalDataSourceImpl(box);
}

class PolicyLocalDataSourceImpl implements PolicyLocalDataSource {
  final Box box;

  PolicyLocalDataSourceImpl(this.box);

  @override
  Future<void> putPolicy(Policy policy, PolicyModel policyModel) async {
    await box.put(policy.name, policyModel);
  }

  @override
  Future<PolicyModel> getPolicy(Policy policy) async {
    if (!box.containsKey(policy.name)) {
      throw HiveError('해당하는 키가 존재하지 않음.');
    }

    return await box.get(policy.name);
  }
}
