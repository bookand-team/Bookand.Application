import 'package:bookand/core/theme/custom_text_style.dart';
import 'package:bookand/domain/model/policy_model.dart';
import 'package:bookand/presentation/provider/member_provider.dart';
import 'package:bookand/presentation/provider/terms_agree_provider.dart';
import 'package:bookand/presentation/screen/terms/terms_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../core/app_strings.dart';
import '../../../core/layout/common_layout.dart';
import '../../../domain/model/member_model.dart';
import '../../component/check_button.dart';
import '../../component/circle_check_button.dart';
import '../../component/custom_dialog.dart';
import '../../component/round_rect_button.dart';
import '../../provider/policy_provider.dart';

class TermsAgreeScreen extends ConsumerWidget with CustomDialog {
  static String get routeName => 'termsAgree';

  const TermsAgreeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final termsAgreeProvider = ref.watch(termsAgreeStateNotifierProvider);
    final policyProvider = ref.watch(policyStateNotifierProvider.notifier);
    final memberProvider = ref.watch(memberStateNotifierProvider.notifier);
    final isLoading = ref.watch(memberStateNotifierProvider) is MemberModelLoading ||
        ref.watch(policyStateNotifierProvider) is PolicyModelLoading;

    return CommonLayout(
        onWillPop: () async {
          memberProvider.cancelSignUp();
          return false;
        },
        ignoring: isLoading,
        isLoading: isLoading,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.background,
          automaticallyImplyLeading: false,
          leading: InkWell(
            onTap: () {
              memberProvider.cancelSignUp();
            },
            radius: 20,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: SvgPicture.asset(
              'assets/images/ic_arrow_back.svg',
              fit: BoxFit.none,
            ),
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 70),
                child: Text(
                  AppStrings.termsAgreeDescription,
                  style: const TextStyle().termsOfServicePageTitle(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 34),
                child: Row(
                  children: [
                    CircleCheckButton(
                      value: !termsAgreeProvider.containsValue(false),
                      onTap: () {
                        ref.watch(termsAgreeStateNotifierProvider.notifier).updateAllAgree();
                      },
                    ),
                    Text(
                      AppStrings.allAgree,
                      style: const TextStyle().termsOfServiceAllAgreeText(),
                    )
                  ],
                ),
              ),
              ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: termsAgreeProvider.keys.length,
                  itemBuilder: (context, index) {
                    final key = termsAgreeProvider.keys.toList()[index];

                    return ListTile(
                      leading: CheckButton(
                          value: termsAgreeProvider[key]!,
                          onTap: () {
                            ref.watch(termsAgreeStateNotifierProvider.notifier).updateAgree(key);
                          }),
                      title: Text(
                          '${key.title}${key.isConsentRequired ? AppStrings.required : AppStrings.optional}',
                          style: const TextStyle().termsOfServiceItemText()),
                      trailing: Visibility(
                        visible: key.hasDocs,
                        child: InkWell(
                          onTap: () {
                            policyProvider.fetchPolicy(
                              policy: key,
                              onSuccess: () {
                                context.goNamed(TermsAgreeDetailScreen.routeName, extra: key);
                              },
                              onError: (msg) {
                                showOneBtnDialog(context: context, content: msg);
                              },
                            );
                          },
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          child: Container(
                            width: 60,
                            height: 52,
                            alignment: Alignment.center,
                            child: SvgPicture.asset('assets/images/ic_arrow_forward.svg',
                                width: 20, height: 20),
                          ),
                        ),
                      ),
                      contentPadding: EdgeInsets.zero,
                      horizontalTitleGap: 0,
                      minLeadingWidth: 0,
                    );
                  }),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 52),
                child: RoundRectButton(
                  text: AppStrings.start,
                  width: MediaQuery.of(context).size.width,
                  height: 56,
                  onPressed: () {
                    memberProvider.signUp().onError((e, _) {
                      showOneBtnDialog(
                          context: context,
                          content: '${AppStrings.signInError}\nError: ${e.toString()}');
                    });
                  },
                  enabled: !termsAgreeProvider.containsValue(false),
                ),
              ),
            ],
          ),
        ));
  }
}
