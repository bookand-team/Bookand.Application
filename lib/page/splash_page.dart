import 'package:bookand/config/theme/custom_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SplashPage extends StatelessWidget {
  static String get routeName => 'splash';

  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Center(
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
              const CircularProgressIndicator(color: Colors.white)
            ],
          ),
        ),
      ),
    );
  }
}
