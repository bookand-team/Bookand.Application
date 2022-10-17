import 'dart:io';

import 'package:bookand/app/provider/login_provider.dart';
import 'package:bookand/theme/custom_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../widget/social_login_button.dart';

class LoginPage extends HookConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final socialLogin = ref.watch(socialLoginProvider);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 127),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Platform.isIOS
                  ? Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: SocialLoginButton(
                          onTap: () {},
                          width: MediaQuery.of(context).size.width,
                          height: 44,
                          radius: 8,
                          image: SvgPicture.asset('assets/images/ic_apple.svg',
                              width: 18, height: 18),
                          text: Text(AppLocalizations.of(context)!.appleSocial,
                              style: const TextStyle().socialLoginText())))
                  : const SizedBox(),
              SocialLoginButton(
                  onTap: () {
                    socialLogin.login(SocialType.google);
                  },
                  width: MediaQuery.of(context).size.width,
                  height: 44,
                  radius: 8,
                  image: SvgPicture.asset('assets/images/ic_google.svg',
                      width: 18, height: 18),
                  text: Text(AppLocalizations.of(context)!.googleSocial,
                      style: const TextStyle().socialLoginText()))
            ],
          ),
        ),
      ),
    );
  }
}
