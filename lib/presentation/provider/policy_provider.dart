import 'package:bookand/core/app_strings.dart';
import 'package:bookand/domain/model/policy_model.dart';
import 'package:bookand/domain/usecase/get_policy_use_case.dart';
import 'package:bookand/presentation/provider/auth_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/const/auth_state.dart';
import '../../core/const/policy.dart';
import '../../core/util/logger.dart';

part 'policy_provider.g.dart';

@riverpod
class PolicyStateNotifier extends _$PolicyStateNotifier {
  late final authState = ref.read(authStateNotifierProvider.notifier);

  @override
  PolicyModel build() => PolicyModel();

  void fetchPolicy({
    required Policy policy,
    required Function() onSuccess,
    required Function(String) onError,
  }) async {
    authState.changeState(AuthState.loading);

    try {
      state = await ref.read(getPolicyUseCaseProvider).getPolicy(policy);
      onSuccess();
    } catch (e, stack) {
      logger.e('약관 불러오기 실패', e, stack);
      onError(AppStrings.termsLoadError);
    } finally {
      authState.changeState(AuthState.signUp);
    }
  }
}
