import 'package:bookand/core/app_strings.dart';
import 'package:bookand/domain/model/policy_model.dart';
import 'package:bookand/domain/usecase/get_policy_use_case.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/const/policy.dart';
import '../../core/util/logger.dart';

part 'policy_provider.g.dart';

@riverpod
class PolicyStateNotifier extends _$PolicyStateNotifier {
  @override
  PolicyModelBase build() => PolicyModelInit();

  void fetchPolicy({
    required Policy policy,
    required Function() onSuccess,
    required Function(String) onError,
  }) async {
    state = PolicyModelLoading();

    try {
      state = await ref.read(getPolicyUseCaseProvider).getPolicy(policy);
      onSuccess();
    } catch (e, stack) {
      logger.e('약관 불러오기 실패', e, stack);
      state = PolicyModelInit();
      onError(AppStrings.termsLoadError);
    }
  }
}
