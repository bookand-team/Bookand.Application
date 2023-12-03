import 'package:bookand/core/theme/color_table.dart';
import 'package:bookand/core/widget/base_app_bar.dart';
import 'package:bookand/core/widget/base_layout.dart';
import 'package:bookand/presentation/component/round_rect_button.dart';
import 'package:bookand/presentation/provider/member_provider.dart';
import 'package:bookand/presentation/screen/main/my/withdrawal/withdrawal_reason_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/app_strings.dart';

class WithdrawalCheckScreen extends ConsumerWidget {
  static String get routeName => 'withdrawalCheck';

  const WithdrawalCheckScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final member = ref.read(memberStateNotifierProvider);

    return BaseLayout(
      appBar: const BaseAppBar(),
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 56),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${member.nickname}${AppStrings.withdrawalCheckTitle}',
              style: const TextStyle(
                color: Color(0xFF222222),
                fontWeight: FontWeight.w600,
                fontSize: 24,
                letterSpacing: -0.02,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              AppStrings.withdrawalCheckDescription,
              style: TextStyle(
                color: Color(0xFF565656),
                fontWeight: FontWeight.w500,
                fontSize: 14,
                letterSpacing: -0.02,
              ),
            ),
            const Spacer(),
            RoundRectButton(
              text: AppStrings.continuously,
              width: MediaQuery.of(context).size.width,
              height: 56,
              backgroundColor: lightErrorColor,
              onPressed: () => context.pushNamed(WithdrawalReasonScreen.routeName),
            ),
          ],
        ),
      ),
    );
  }
}
