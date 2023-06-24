import 'package:bookand/core/theme/color_table.dart';
import 'package:bookand/core/widget/base_layout.dart';
import 'package:bookand/presentation/provider/auth_provider.dart';
import 'package:bookand/presentation/provider/member_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/app_strings.dart';
import '../../core/const/auth_state.dart';
import '../component/round_rect_button.dart';

class WelcomeScreen extends ConsumerWidget {
  static String get routeName => 'welcome';

  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BaseLayout(
      onWillPop: () async {
        ref.read(authStateNotifierProvider.notifier).changeState(AuthState.signIn);
        return false;
      },
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '반가워요\n${ref.read(memberStateNotifierProvider).nickname}님!',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 30.sp,
                        letterSpacing: -0.02,
                        color: lightColorFF222222,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 26),
                    Text(
                      '북앤드와 함께 보석같은 독립서점을\n찾아갈 수 있기를 바라요.',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14.sp,
                        letterSpacing: -0.02,
                        color: const Color(0xFF999999),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 56.h),
                    Image.asset(
                      'assets/images/welcome_image.png',
                      width: 284.w,
                      fit: BoxFit.fitWidth,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 22.h, left: 16.w, right: 16.w),
              child: RoundRectButton(
                  text: AppStrings.start,
                  textStyle: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18.sp,
                    color: Colors.white,
                    letterSpacing: -0.02,
                  ),
                  width: MediaQuery.of(context).size.width,
                  height: 52.h,
                  onPressed: () {
                    ref.read(authStateNotifierProvider.notifier).changeState(AuthState.signIn);
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
