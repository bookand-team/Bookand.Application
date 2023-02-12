import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/const/policy.dart';

part 'terms_agree_provider.g.dart';

@riverpod
class TermsAgreeStateNotifier extends _$TermsAgreeStateNotifier {
  @override
  Map<Policy, bool> build() => {
        Policy.age: false,
        Policy.terms: false,
        Policy.personalInfoAgree: false,
      };

  void updateAllAgree() {
    final copyMap = Map<Policy, bool>.from(state);
    final isNotAllAgree = copyMap.containsValue(false);
    copyMap.updateAll((_, __) => isNotAllAgree);
    state = copyMap;
  }

  void updateAgree(Policy key, {bool? isAgree}) {
    final copyMap = Map<Policy, bool>.from(state);
    copyMap.update(key, (value) => isAgree ?? !value);
    state = copyMap;
  }
}
