import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/const/revoke_type.dart';

part 'withdrawal_reason_provider.g.dart';

class WithdrawalReasonState {
  RevokeType? revokeType;
  String? reason;

  WithdrawalReasonState({this.revokeType, this.reason});

  WithdrawalReasonState copyWith({RevokeType? revokeType, String? reason}) {
    return WithdrawalReasonState(
      revokeType: revokeType ?? this.revokeType,
      reason: reason ?? this.reason,
    );
  }
}

@riverpod
class WithdrawalReasonStateNotifier extends _$WithdrawalReasonStateNotifier {
  @override
  WithdrawalReasonState build() => WithdrawalReasonState();

  void changeWithdrawalReason({RevokeType? revokeType, String? reason}) {
    if (revokeType == RevokeType.etc) {
      state = state.copyWith(revokeType: revokeType, reason: reason);
    } else {
      state = state.copyWith(revokeType: revokeType, reason: null);
    }
  }
}
