import 'package:bookand/page/terms_page.dart';
import 'package:bookand/theme/custom_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../widget/check_button.dart';
import '../../widget/circle_check_button.dart';
import '../../widget/round_rect_button.dart';
import '../notifier/terms_provider.dart';

class TermsAgreePage extends HookConsumerWidget {
  const TermsAgreePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allAgreeState = ref.watch(allAgreeProvider.notifier);
    final agree14YearsOfAgeOrOlderState = ref.watch(agree14YearsOfAgeOrOlderProvider.notifier);
    final agreeTermsOfServiceState = ref.watch(agreeTermsOfServiceProvider.notifier);

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          radius: 20,
          highlightColor: Colors.transparent,
          child: SvgPicture.asset(
            'assets/images/ic_arrow_back.svg',
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
                AppLocalizations.of(context)!.termsOfServiceAgree,
                style: const TextStyle().termsOfServicePageTitle(),
              ),
              const SizedBox(height: 70),
              Row(
                children: [
                  CircleCheckButton(
                    value: ref.watch(allAgreeProvider),
                    onTap: () {
                      allAgreeState.changeAgree();
                    },
                  ),
                  const SizedBox(width: 19),
                  Text(
                    AppLocalizations.of(context)!.allAgree,
                    style: const TextStyle().termsOfServiceAllAgreeText(),
                  )
                ],
              ),
              const SizedBox(height: 50),
              Row(
                children: [
                  CheckButton(
                      value: ref.watch(agree14YearsOfAgeOrOlderProvider),
                      onTap: () {
                        agree14YearsOfAgeOrOlderState.state = !agree14YearsOfAgeOrOlderState.state;
                        allAgreeState.checkAgreeList();
                      }),
                  const SizedBox(width: 20),
                  Text(AppLocalizations.of(context)!.termsOfServiceItem1,
                      style: const TextStyle().termsOfServiceItemText())
                ],
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CheckButton(
                          value: ref.watch(agreeTermsOfServiceProvider),
                          onTap: () {
                            agreeTermsOfServiceState.state = !agreeTermsOfServiceState.state;
                            allAgreeState.checkAgreeList();
                          }),
                      const SizedBox(width: 20),
                      Text(AppLocalizations.of(context)!.termsOfServiceItem2,
                          style: const TextStyle().termsOfServiceItemText())
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => TermsPage(
                                  title: AppLocalizations.of(context)!
                                      .termsOfService,
                                  // TODO: 데이터 받아와서 넣어줘야함.
                                  content: ""))).then((value) {
                        if (value ?? false) {
                          ref
                              .watch(agreeTermsOfServiceProvider.notifier)
                              .state = value;
                        }
                      });
                    },
                    child: SvgPicture.asset(
                        'assets/images/ic_arrow_forward.svg',
                        width: 20,
                        height: 20),
                  )
                ],
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CheckButton(
                          value: ref.watch(agreeCollectAndUsePrivacyProvider),
                          onTap: () {
                            var agree = ref.watch(
                                agreeCollectAndUsePrivacyProvider.notifier);
                            agree.state = !agree.state;
                            allAgreeState.checkAgreeList();
                          }),
                      const SizedBox(width: 20),
                      Text(AppLocalizations.of(context)!.termsOfServiceItem3,
                          style: const TextStyle().termsOfServiceItemText())
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => TermsPage(
                                  title: AppLocalizations.of(context)!
                                      .collectAndUsePrivacy,
                                  // TODO: 데이터 받아와서 넣어줘야함.
                                  content: ""))).then((value) {
                        if (value ?? false) {
                          ref
                              .watch(agreeCollectAndUsePrivacyProvider.notifier)
                              .state = value;
                        }
                      });
                    },
                    child: SvgPicture.asset(
                        'assets/images/ic_arrow_forward.svg',
                        width: 20,
                        height: 20),
                  )
                ],
              ),
              const Spacer(),
              RoundRectButton(
                  text: AppLocalizations.of(context)!.start,
                  width: MediaQuery.of(context).size.width,
                  height: 56,
                  onPressed: () {},
                  enabled: ref.watch(allAgreeProvider))
            ],
          ),
        ),
      ),
    );
  }
}
