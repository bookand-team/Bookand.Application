import 'dart:io';

import 'package:bookand/core/widget/base_dialog.dart';
import 'package:bookand/core/theme/custom_text_style.dart';
import 'package:bookand/presentation/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/app_strings.dart';
import '../../core/const/auth_state.dart';
import '../../core/const/social_type.dart';
import '../../core/widget/base_layout.dart';
import '../../domain/usecase/get_policy_use_case.dart';
import '../component/social_login_button.dart';
import '../provider/member_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  static String get routeName => 'login';

  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  @override
  void didChangeDependencies() {
    ref.read(memberStateNotifierProvider.notifier).fetchMemberInfo();
    ref.read(getPolicyUseCaseProvider).fetchAllPolicy();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final memberProvider = ref.watch(memberStateNotifierProvider.notifier);
    final authState = ref.watch(authStateNotifierProvider);

    return BaseLayout(
      backgroundColor: Colors.black,
      ignoring: authState == AuthState.loading,
      isLoading: authState == AuthState.loading,
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
                        memberProvider.socialLogin(
                          socialType: SocialType.APPLE,
                          onError: (errMsg) {
                            showDialog(
                              context: context,
                              builder: (_) => BaseDialog(
                                content: Text(errMsg),
                              ),
                            );
                          },
                        );
                      },
                      image: SvgPicture.asset('assets/images/ic_apple.svg', width: 24),
                      text: Text(AppStrings.appleSocial, style: const TextStyle().appleLoginText()))
                  : const SizedBox(height: 56),
              const SizedBox(height: 16),
              SocialLoginButton(
                  onTap: () {
                    memberProvider.socialLogin(
                      socialType: SocialType.GOOGLE,
                      onError: (errMsg) {
                        showDialog(
                          context: context,
                          builder: (_) => BaseDialog(
                            content: Text(errMsg),
                          ),
                        );
                      },
                    );
                  },
                  image: SvgPicture.asset('assets/images/ic_google.svg', width: 24),
                  text: Text(AppStrings.googleSocial, style: const TextStyle().googleLoginText()))
            ],
          ),
        ),
      ),
    );
  }
}
