import 'package:bookand/core/widget/base_dialog.dart';
import 'package:bookand/domain/model/error_response.dart';
import 'package:bookand/presentation/screen/main/my/withdrawal/withdrawal_success_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/app_strings.dart';
import '../../../../../core/theme/color_table.dart';
import '../../../../../core/util/logger.dart';
import '../../../../../core/widget/base_app_bar.dart';
import '../../../../../core/widget/base_layout.dart';
import '../../../../component/round_rect_button.dart';
import '../../../../provider/member_provider.dart';
import '../../../../provider/withdrawal_reason_provider.dart';

class AccountAuthenticationSuccessScreen extends ConsumerStatefulWidget {
  static String get routeName => 'accountAuthenticationSuccessScreen';

  final String socialAccessToken;

  const AccountAuthenticationSuccessScreen({
    Key? key,
    required this.socialAccessToken,
  }) : super(key: key);

  @override
  ConsumerState<AccountAuthenticationSuccessScreen> createState() =>
      _AccountAuthenticationSuccessScreenState();
}

class _AccountAuthenticationSuccessScreenState
    extends ConsumerState<AccountAuthenticationSuccessScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      appBar: const BaseAppBar(),
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 56),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              AppStrings.accountAuthenticationSuccessTitle,
              style: TextStyle(
                color: Color(0xFF222222),
                fontWeight: FontWeight.w600,
                fontSize: 24,
                letterSpacing: -0.02,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              AppStrings.accountAuthenticationSuccessDescription,
              style: TextStyle(
                color: Color(0xFF565656),
                fontWeight: FontWeight.w500,
                fontSize: 14,
                letterSpacing: -0.02,
              ),
            ),
            const Spacer(),
            RoundRectButton(
              text: AppStrings.deleteAccount,
              width: MediaQuery.of(context).size.width,
              height: 56,
              backgroundColor: lightErrorColor,
              onPressed: () {
                final revokeReason = ref.read(withdrawalReasonStateNotifierProvider);
                ref
                    .read(memberStateNotifierProvider.notifier)
                    .withdrawal(
                      widget.socialAccessToken,
                      revokeReason.revokeType!,
                      revokeReason.reason,
                    )
                    .then((_) {
                  context.goNamed(WithdrawalSuccessScreen.routeName);
                }, onError: (e) {
                  if (e is ErrorResponse) {
                    showDialog(
                      context: context,
                      builder: (_) => BaseDialog(
                        content: Text(e.message.toString()),
                      ),
                    );
                  } else {
                    logger.e(e);
                    showDialog(
                      context: context,
                      builder: (_) => BaseDialog(
                        content: Text('탈퇴 진행 중 문제가 발생하였습니다.\n에러: $e'),
                      ),
                    );
                  }
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
