import 'package:bookand/theme/custom_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../widget/round_rect_button.dart';

class TermsPage extends StatelessWidget {
  final String title;
  final String content;

  const TermsPage(
      {super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        surfaceTintColor: Theme.of(context).backgroundColor,
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context, false);
          },
          radius: 20,
          highlightColor: Colors.transparent,
          child: SvgPicture.asset(
            'assets/images/ic_close.svg',
            fit: BoxFit.none,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 56),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle().termsOfServiceContentsScreenTitle(),
              ),
              Expanded(
                  child: Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 14),
                      child: Markdown(
                          controller: ScrollController(),
                          data: content,
                          padding: const EdgeInsets.symmetric(vertical: 5)))),
              RoundRectButton(
                  text: AppLocalizations.of(context)!.agree,
                  width: MediaQuery.of(context).size.width,
                  height: 56,
                  onPressed: () {
                    Navigator.pop(context, true);
                  })
            ],
          ),
        ),
      ),
    );
  }
}
