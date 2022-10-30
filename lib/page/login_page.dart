import 'package:bookand/data/repository/login/login_repository_impl.dart';
import 'package:bookand/notifier/login/login_state.dart';
import 'package:bookand/notifier/login/login_state_notifier.dart';
import 'package:bookand/page/terms_agree_page.dart';
import 'package:bookand/theme/custom_text_style.dart';
import 'package:bookand/widget/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../widget/social_login_button.dart';
import '../const/login_result.dart';

final loginStateNotifierProvider = StateNotifierProvider<LoginStateNotifier, LoginState>(
    (ref) => LoginStateNotifier(ref, LoginRepositoryImpl()));

class LoginPage extends HookConsumerWidget with CustomDialog {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Consumer(
          builder: (context, ref, child) {
            final state = ref.watch(loginStateNotifierProvider);

            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (state is LoginLoaded) {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const TermsAgreePage()));
              } else if (state is LoginError) {
                var message = '';

                switch (state.loginResult) {
                  case LoginResult.cancel:
                    message = AppLocalizations.of(context)!.loginCancel;
                    break;
                  case LoginResult.error:
                    message = AppLocalizations.of(context)!.loginError;
                    break;
                }

                showInfoDialog(context, AppLocalizations.of(context)!.info, message,
                    AppLocalizations.of(context)!.ok, () => Navigator.pop(context));
              }
            });

            return IgnorePointer(
              ignoring: state is LoginLoading,
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset('assets/images/ic_logo.svg', width: 61, height: 70),
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
                        //
                        //             },
                        //             image: SvgPicture.asset('assets/images/ic_apple.svg',
                        //                 width: 24, height: 24),
                        //             text: Text(AppLocalizations.of(context)!.appleSocial,
                        //                 style: const TextStyle().appleLoginText())))
                        //     : const SizedBox(),
                        SocialLoginButton(
                            onTap: () {
                              ref.watch(loginStateNotifierProvider.notifier).googleLogin();
                            },
                            image: SvgPicture.asset('assets/images/ic_google.svg',
                                width: 24, height: 24),
                            text: Text(AppLocalizations.of(context)!.googleSocial,
                                style: const TextStyle().googleLoginText()))
                      ],
                    ),
                  ),
                  state is LoginLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : const SizedBox()
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
