import 'package:bookand/presentation/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/app_strings.dart';
import '../../../../../core/const/auth_state.dart';
import '../../../../../core/widget/base_app_bar.dart';
import '../../../../../core/widget/base_layout.dart';

class WithdrawalSuccessScreen extends ConsumerWidget {
  static String get routeName => 'withdrawalSuccessScreen';

  const WithdrawalSuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BaseLayout(
      onWillPop: () async {
        ref.read(authStateNotifierProvider.notifier).changeState(AuthState.init);
        return false;
      },
      appBar: BaseAppBar(
        leading: InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () => ref.read(authStateNotifierProvider.notifier).changeState(AuthState.init),
          child: Padding(
            padding: const EdgeInsets.only(left: 16),
            child: SvgPicture.asset(
              'assets/images/ic_close.svg',
            ),
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 56),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              AppStrings.withdrawalSuccessTitle,
              style: TextStyle(
                color: Color(0xFF222222),
                fontWeight: FontWeight.w600,
                fontSize: 24,
                letterSpacing: -0.02,
              ),
            ),
            SizedBox(height: 16),
            Text(
              AppStrings.withdrawalSuccessDescription,
              style: TextStyle(
                color: Color(0xFF565656),
                fontWeight: FontWeight.w500,
                fontSize: 14,
                letterSpacing: -0.02,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
