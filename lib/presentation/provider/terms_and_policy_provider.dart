import 'package:bookand/core/const/hive_key.dart';
import 'package:hive/hive.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/const/policy.dart';
import '../../domain/model/policy_model.dart';

part 'terms_and_policy_provider.g.dart';

@riverpod
List<PolicyModel> termsAndPolicy(TermsAndPolicyRef ref) {
  final box = Hive.box(HiveKey.policyBoxKey);
  final policyList = Policy.values.map((e) => box.get(e.name)).toList();
  return List.castFrom(policyList);
}
