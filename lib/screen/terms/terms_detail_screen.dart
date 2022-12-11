import 'package:bookand/common/layout/common_layout.dart';
import 'package:bookand/common/theme/custom_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_svg/svg.dart';

import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../widget/round_rect_button.dart';

class TermsAgreeDetailScreen extends StatelessWidget {
  static String get routeName => 'termsAgreeDetail';
  final String id;

  const TermsAgreeDetailScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return CommonLayout(
      appBar: AppBar(
        surfaceTintColor: Theme.of(context).backgroundColor,
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () {
            context.pop();
          },
          radius: 20,
          highlightColor: Colors.transparent,
          child: SvgPicture.asset(
            'assets/images/ic_close.svg',
            fit: BoxFit.none,
          ),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 56),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'title',
                style: const TextStyle().termsOfServiceContentsScreenTitle(),
              ),
              Expanded(
                  child: Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 14),
                      child: Markdown(
                          controller: ScrollController(),
                          data: 'content',
                          padding: const EdgeInsets.symmetric(vertical: 5)))),
              RoundRectButton(
                  text: Intl.message('agree'),
                  width: MediaQuery.of(context).size.width,
                  height: 56,
                  onPressed: () {
                    context.pop();
                  })
            ],
          ),
        ),
      ),
    );
  }
}
