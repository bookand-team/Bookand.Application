import 'package:collection/collection.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/const/policy.dart';
import '../../domain/model/policy_model.dart';
import '../../domain/usecase/get_policy_use_case.dart';

part 'terms_agree_provider.g.dart';

class TermsAgreeState {
  final String policyKey;
  bool isRequired;
  bool isAgree;
  PolicyModel? policyModel;

  TermsAgreeState({
    required this.policyKey,
    required this.isRequired,
    required this.isAgree,
    this.policyModel,
  });

  TermsAgreeState copyWith(
      {String? policyKey, bool? isRequired, bool? isAgree, PolicyModel? policyModel}) {
    return TermsAgreeState(
        policyKey: policyKey ?? this.policyKey,
        isRequired: isRequired ?? this.isRequired,
        isAgree: isAgree ?? this.isAgree,
        policyModel: policyModel ?? this.policyModel);
  }
}

@riverpod
class TermsAgreeStateNotifier extends _$TermsAgreeStateNotifier {
  @override
  List<TermsAgreeState> build() {
    _fetchPolicy();
    return [];
  }

  void updateAllAgree() {
    final agreeList = state.map((e) => e.isAgree).toList();
    final isNotAllAgree = agreeList.contains(false);
    state = state.map((e) => e.copyWith(isAgree: isNotAllAgree)).toList();
  }

  void updateAgree(int index, {bool? isAgree}) {
    final List<TermsAgreeState> copyList = List.from(state);
    copyList[index] = copyList[index].copyWith(isAgree: isAgree ?? !copyList[index].isAgree);
    state = copyList;
  }

  void _fetchPolicy() async {
    final items = [
      TermsAgreeState(policyKey: 'age', isRequired: true, isAgree: false),
      TermsAgreeState(policyKey: Policy.terms.name, isRequired: true, isAgree: false),
      TermsAgreeState(policyKey: Policy.personalInfoAgree.name, isRequired: true, isAgree: false),
    ];

    for (var item in items) {
      final policy = Policy.values.firstWhereOrNull((e) => e.name == item.policyKey);
      if (policy != null) {
        final policyModel = await ref.read(getPolicyUseCaseProvider).getPolicy(policy);
        item.policyModel = policyModel;
      }
    }

    state = items;
  }
}
