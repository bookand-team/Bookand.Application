import 'package:bookand/core/const/auth_state.dart';
import 'package:bookand/data/repository/member_repository_impl.dart';
import 'package:bookand/domain/model/member/member_model.dart';
import 'package:bookand/presentation/provider/auth_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/util/logger.dart';

part 'deeplink_provider.g.dart';

@riverpod
class DeeplinkProvider extends _$DeeplinkProvider {
  late final authState = ref.read(authStateNotifierProvider.notifier);
  late final memberRepository = ref.read(memberRepositoryProvider);

  @override
  MemberModel build() => MemberModel();

  void fetchMemberInfo({required Function onSuccess}) async {
    try {
      state = await memberRepository.getMe();
      authState.changeState(AuthState.signIn);
      onSuccess();
    } catch (e, stack) {
      logger.e('사용자 정보를 불러올 수 없음', e, stack);
      authState.changeState(AuthState.init);
    }
  }
}
