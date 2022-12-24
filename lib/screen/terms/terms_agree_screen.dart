import 'package:bookand/common/layout/common_layout.dart';
import 'package:bookand/common/theme/custom_text_style.dart';
import 'package:bookand/screen/terms/terms_detail_screen.dart';
import 'package:bookand/provider/user_me_provider.dart';
import 'package:bookand/widget/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../widget/check_button.dart';
import '../../../widget/circle_check_button.dart';
import '../../../widget/round_rect_button.dart';
import '../../data/model/user_model.dart';
import '../../provider/terms_provider.dart';

class TermsAgreeScreen extends ConsumerWidget with CustomDialog {
  static String get routeName => 'termsAgree';

  const TermsAgreeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userMeProvider);
    final state = ref.watch(userMeProvider.notifier);
    final allAgreeState = ref.watch(allAgreeProvider.notifier);
    final agree14YearsOfAgeOrOlderState = ref.watch(agree14YearsOfAgeOrOlderProvider.notifier);
    final agreeTermsOfServiceState = ref.watch(agreeTermsOfServiceProvider.notifier);

    return CommonLayout(
        onWillPop: () async {
          state.cancelSignUp();
          return false;
        },
        ignoring: user is UserModelLoading,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: InkWell(
            onTap: () {
              state.cancelSignUp();
            },
            radius: 20,
            highlightColor: Colors.transparent,
            child: SvgPicture.asset(
              'assets/images/ic_arrow_back.svg',
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
                Intl.message('termsOfServiceAgree'),
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
                    Intl.message('allAgree'),
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
                  Text(Intl.message('termsOfServiceItem1'),
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
                      Text(Intl.message('termsOfServiceItem2'),
                          style: const TextStyle().termsOfServiceItemText())
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      context.goNamed(TermsAgreeDetailScreen.routeName, params: {'id': 'id'});
                    },
                    child: SvgPicture.asset('assets/images/ic_arrow_forward.svg',
                        width: 20, height: 20),
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
                            var agree = ref.watch(agreeCollectAndUsePrivacyProvider.notifier);
                            agree.state = !agree.state;
                            allAgreeState.checkAgreeList();
                          }),
                      const SizedBox(width: 20),
                      Text(Intl.message('termsOfServiceItem3'),
                          style: const TextStyle().termsOfServiceItemText())
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      context.goNamed(TermsAgreeDetailScreen.routeName, params: {'id': 'id'});
                    },
                    child: SvgPicture.asset('assets/images/ic_arrow_forward.svg',
                        width: 20, height: 20),
                  )
                ],
              ),
              const Spacer(),
              RoundRectButton(
                  text: Intl.message('start'),
                  width: MediaQuery.of(context).size.width,
                  height: 56,
                  onPressed: () {
                    state.signUp();
                  },
                  enabled: ref.watch(allAgreeProvider))
            ],
          ),
        )));
  }
}
