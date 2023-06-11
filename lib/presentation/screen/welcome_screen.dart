import 'package:bookand/core/theme/color_table.dart';
import 'package:bookand/core/widget/base_layout.dart';
import 'package:bookand/presentation/provider/auth_provider.dart';
import 'package:bookand/presentation/provider/member_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/app_strings.dart';
import '../../core/const/auth_state.dart';

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '반가워요\n${ref.read(memberStateNotifierProvider).nickname}님!',
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 30,
                      letterSpacing: -0.02,
                      color: lightColorFF222222,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 26),
                  const Text(
                    '북앤드와 함께 보석같은 독립서점을\n찾아갈 수 있기를 바라요.',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      letterSpacing: -0.02,
                      color: Color(0xFF999999),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 56),
                  Image.asset(
                    'assets/images/welcome_image.png',
                    width: 284,
                    fit: BoxFit.fitWidth,
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              ref.read(authStateNotifierProvider.notifier).changeState(AuthState.signIn);
            },
            child: Container(
              color: lightColorFF222222,
              width: MediaQuery.of(context).size.width,
              height: 72,
              alignment: Alignment.center,
              child: const Text(
                AppStrings.start,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                  letterSpacing: -0.02,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
