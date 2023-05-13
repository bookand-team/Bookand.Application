import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/widget/base_app_bar.dart';
import '../../../../../core/widget/base_layout.dart';
import '../../../../../core/app_strings.dart';
import '../../../../component/round_rect_button.dart';
import '../../../../provider/main_tab_provider.dart';

class NewBookstoreReportSuccessScreen extends ConsumerWidget {
  static String get routeName => 'newBookstoreReportSuccess';

  const NewBookstoreReportSuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BaseLayout(
      appBar: BaseAppBar(
        leading: InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () {
            context.pop();
          },
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
          children: [
            const Text(
              AppStrings.newBookstoreReportSuccessTitle,
              style: TextStyle(
                color: Color(0xFF222222),
                fontWeight: FontWeight.w600,
                fontSize: 24,
                letterSpacing: -0.02,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              AppStrings.newBookstoreReportSuccessDescription,
              style: TextStyle(
                color: Color(0xFF565656),
                fontWeight: FontWeight.w500,
                fontSize: 14,
                letterSpacing: -0.02,
              ),
            ),
            const Spacer(),
            RoundRectButton(
              text: AppStrings.goHome,
              width: MediaQuery.of(context).size.width,
              height: 56,
              onPressed: () {
                ref.watch(mainTabNotifierProvider.notifier).changeHomeScreen();
                context.pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
