import 'dart:io';

import 'package:bookand/theme/custom_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../const/social_login_const.dart';
import '../../widget/social_login_button.dart';
import '../provider/login_provider.dart';

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
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/images/ic_logo.svg',
                  width: 61, height: 70),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 110),
                child: Text(
                  AppLocalizations.of(context)!.appName,
                  style: const TextStyle().logoText(),
                ),
              ),
              // Platform.isIOS
              //     ? Padding(
              //         padding: const EdgeInsets.only(bottom: 12),
              //         child: SocialLoginButton(
              //             onTap: () {
              //               socialLogin.login(SocialType.apple);
              //             },
              //             width: MediaQuery.of(context).size.width,
              //             height: 56,
              //             radius: 8,
              //             image: SvgPicture.asset('assets/images/ic_apple.svg',
              //                 width: 24, height: 24),
              //             text: Text(AppLocalizations.of(context)!.appleSocial,
              //                 style: const TextStyle().appleLoginText())))
              //     : const SizedBox(),
              SocialLoginButton(
                  onTap: () {
                    socialLogin.login(SocialType.google);
                  },
                  width: MediaQuery.of(context).size.width,
                  height: 56,
                  radius: 8,
                  image: SvgPicture.asset('assets/images/ic_google.svg',
                      width: 24, height: 24),
                  text: Text(AppLocalizations.of(context)!.googleSocial,
                      style: const TextStyle().googleLoginText()))
            ],
          ),
        ),
      ),
    );
  }
}
