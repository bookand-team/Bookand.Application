import 'dart:io';

import 'package:bookand/core/theme/custom_text_style.dart';
import 'package:bookand/domain/model/member/member_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/app_strings.dart';
import '../../core/layout/common_layout.dart';
import '../component/custom_dialog.dart';
import '../component/social_login_button.dart';
import '../provider/member_provider.dart';

class LoginScreen extends ConsumerWidget with CustomDialog {
  static String get routeName => 'login';

  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(memberStateNotifierProvider);
    final state = ref.watch(memberStateNotifierProvider.notifier);

    return CommonLayout(
      backgroundColor: Colors.black,
      ignoring: user is MemberModelLoading,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(bottom: 80.h, left: 16, right: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SvgPicture.asset('assets/images/ic_logo_and_title.svg', width: 120.w),
              SizedBox(height: 158.h),
              Platform.isIOS
                  ? SocialLoginButton(
                      onTap: () {
                        state.appleLogin(onError: (errMsg) {
                          showOneBtnDialog(context: context, content: errMsg);
                        });
                      },
                      image: SvgPicture.asset('assets/images/ic_apple.svg', width: 24),
                      text: Text(AppStrings.appleSocial,
                          style: const TextStyle().appleLoginText()))
                  : const SizedBox(height: 56),
              const SizedBox(height: 16),
              SocialLoginButton(
                  onTap: () {
                    state.googleLogin(onError: (errMsg) {
                      showOneBtnDialog(context: context, content: errMsg);
                    });
                  },
                  image: SvgPicture.asset('assets/images/ic_google.svg', width: 24),
                  text: Text(AppStrings.googleSocial,
                      style: const TextStyle().googleLoginText()))
            ],
          ),
        ),
      ),
    );
  }
}
