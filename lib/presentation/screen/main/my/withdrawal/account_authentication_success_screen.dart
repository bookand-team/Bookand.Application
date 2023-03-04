import 'package:bookand/presentation/screen/main/my/withdrawal/withdrawal_success_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/app_strings.dart';
import '../../../../../core/theme/color_table.dart';
import '../../../../../core/widget/base_app_bar.dart';
import '../../../../../core/widget/base_layout.dart';
import '../../../../component/round_rect_button.dart';

class AccountAuthenticationSuccessScreen extends StatelessWidget {
  static String get routeName => 'accountAuthenticationSuccessScreen';

  const AccountAuthenticationSuccessScreen({Key? key}) : super(key: key);

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
              onPressed: () => context.goNamed(WithdrawalSuccessScreen.routeName),
            ),
          ],
        ),
      ),
    );
  }
}
