import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/const/revoke_type.dart';

part 'withdrawal_reason_provider.g.dart';

class WithdrawalReasonState {
  RevokeType? revokeType;
  String? reason;

  WithdrawalReasonState({this.revokeType, this.reason});
}

@riverpod
class WithdrawalReasonStateNotifier extends _$WithdrawalReasonStateNotifier {
  @override
  WithdrawalReasonState build() => WithdrawalReasonState();

  void changeRevokeType(RevokeType? revokeType) {
    state = WithdrawalReasonState(revokeType: revokeType);
  }
}
