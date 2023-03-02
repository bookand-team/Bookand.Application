import 'package:bookand/core/theme/custom_text_style.dart';
import 'package:bookand/presentation/provider/policy_provider.dart';
import 'package:bookand/presentation/provider/terms_agree_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import 'package:go_router/go_router.dart';

import '../../../core/app_strings.dart';
import '../../../core/const/policy.dart';
import '../../../core/widget/base_layout.dart';
import '../../component/round_rect_button.dart';

class TermsAgreeDetailScreen extends ConsumerWidget {
  static String get routeName => 'termsAgreeDetail';

  final Policy policy;

  const TermsAgreeDetailScreen({super.key, required this.policy});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final policyModel = ref.watch(policyStateNotifierProvider);

    return BaseLayout(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        surfaceTintColor: Theme.of(context).colorScheme.background,
        scrolledUnderElevation: 0,
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
                policy.title,
                style: const TextStyle().termsOfServiceContentsScreenTitle(),
              ),
              Expanded(
                  child: Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 14),
                      child: Markdown(
                          controller: ScrollController(),
                          data: policyModel.content,
                          padding: const EdgeInsets.symmetric(vertical: 5)))),
              RoundRectButton(
                  text: AppStrings.agree,
                  width: MediaQuery.of(context).size.width,
                  height: 56,
                  onPressed: () {
                    ref
                        .watch(termsAgreeStateNotifierProvider.notifier)
                        .updateAgree(policy, isAgree: true);
                    context.pop();
                  })
            ],
          ),
        ),
      ),
    );
  }
}
