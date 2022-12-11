import 'dart:io';

import 'package:bookand/common/layout/common_layout.dart';
import 'package:bookand/common/theme/custom_text_style.dart';
import 'package:bookand/data/model/user_model.dart';
import 'package:bookand/provider/user_me_provider.dart';
import 'package:bookand/widget/custom_dialog.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../../widget/social_login_button.dart';

class LoginScreen extends ConsumerWidget with CustomDialog {
  static String get routeName => 'login';

  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userMeProvider);
    final state = ref.watch(userMeProvider.notifier);

    return CommonLayout(
      backgroundColor: Colors.black,
      ignoring: user is UserModelLoading,
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
                    text: Text(Intl.message('appleSocial'),
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
                text:
                    Text(Intl.message('googleSocial'), style: const TextStyle().googleLoginText()))
          ],
        ),
      )),
    );
  }
}
