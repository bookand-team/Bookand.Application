import 'package:bookand/core/const/social_type.dart';
import 'package:bookand/core/theme/custom_text_style.dart';
import 'package:bookand/core/widget/base_app_bar.dart';
import 'package:bookand/core/widget/base_layout.dart';
import 'package:bookand/presentation/component/social_login_button.dart';
import 'package:bookand/presentation/provider/member_provider.dart';
import 'package:bookand/presentation/screen/main/my/withdrawal/account_authentication_success_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/app_strings.dart';

class AccountAuthenticationScreen extends ConsumerWidget {
  static String get routeName => 'accountAuthenticationScreen';

  const AccountAuthenticationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BaseLayout(
      appBar: const BaseAppBar(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              AppStrings.accountAuthenticationTitle,
              style: TextStyle(
                color: Color(0xFF222222),
                fontWeight: FontWeight.w600,
                fontSize: 24,
                letterSpacing: -0.02,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              '${AppStrings.accountAuthenticationDescription1} ${ref.watch(memberStateNotifierProvider).providerType.name} ${AppStrings.accountAuthenticationDescription2}',
              style: const TextStyle(
                color: Color(0xFF565656),
                fontWeight: FontWeight.w400,
                fontSize: 14,
                letterSpacing: -0.02,
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            socialButton(ref),
          ],
        ),
      ),
    );
  }

  Widget socialButton(WidgetRef ref) {
    switch (ref.watch(memberStateNotifierProvider).providerType) {
      case SocialType.NONE:
        return const SizedBox();
      case SocialType.GOOGLE:
        return SocialLoginButton(
          // onTap: () {},
          onTap: () => ref.context.pushNamed(AccountAuthenticationSuccessScreen.routeName), // TODO: 임시용
          image: SvgPicture.asset('assets/images/ic_google.svg', width: 24),
          text: Text(
            AppStrings.googleSocial,
            style: const TextStyle().googleLoginText(),
          ),
        );
      case SocialType.APPLE:
        return SocialLoginButton(
          // onTap: () {},
          onTap: () => ref.context.pushNamed(AccountAuthenticationSuccessScreen.routeName), // TODO: 임시용
          image: SvgPicture.asset('assets/images/ic_apple.svg', width: 24),
          text: Text(
            AppStrings.appleSocial,
            style: const TextStyle().appleLoginText(),
          ),
        );
    }
  }
}
