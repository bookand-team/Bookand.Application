import 'package:bookand/core/widget/base_dialog.dart';
import 'package:bookand/core/theme/custom_text_style.dart';
import 'package:bookand/presentation/provider/auth_provider.dart';
import 'package:bookand/presentation/provider/member_provider.dart';
import 'package:bookand/presentation/provider/terms_agree_provider.dart';
import 'package:bookand/presentation/screen/terms/terms_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:tuple/tuple.dart';

import '../../../core/app_strings.dart';
import '../../../core/const/auth_state.dart';
import '../../../core/widget/base_layout.dart';
import '../../component/check_button.dart';
import '../../component/circle_check_button.dart';
import '../../component/round_rect_button.dart';

class TermsAgreeScreen extends ConsumerWidget {
  static String get routeName => 'termsAgree';

  const TermsAgreeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final termsAgreeState = ref.watch(termsAgreeStateNotifierProvider);
    final termsAgreeProvider = ref.watch(termsAgreeStateNotifierProvider.notifier);
    final memberProvider = ref.watch(memberStateNotifierProvider.notifier);
    final authState = ref.watch(authStateNotifierProvider);

    return BaseLayout(
      onWillPop: () async {
        memberProvider.cancelSignUp();
        return false;
      },
      ignoring: authState == AuthState.loading,
      isLoading: authState == AuthState.loading,
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
                    value: !termsAgreeState.map((e) => e.isAgree).toList().contains(false),
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
                itemCount: termsAgreeState.length,
                itemBuilder: (context, index) {
                  final policyModel = termsAgreeState[index].policyModel;

                  if (index == 0) {
                    return ListTile(
                      leading: CheckButton(
                          value: termsAgreeState[index].isAgree,
                          onTap: () {
                            termsAgreeProvider.updateAgree(index);
                          }),
                      title: Text(AppStrings.policy14yearsAgeOrOlder,
                          style: const TextStyle().termsOfServiceItemText()),
                      contentPadding: EdgeInsets.zero,
                      horizontalTitleGap: 0,
                      minLeadingWidth: 0,
                    );
                  }

                  return ListTile(
                    leading: CheckButton(
                        value: termsAgreeState[index].isAgree,
                        onTap: () {
                          termsAgreeProvider.updateAgree(index);
                        }),
                    title: Text(
                        '${policyModel?.title}${termsAgreeState[index].isRequired ? AppStrings.required : AppStrings.optional}',
                        style: const TextStyle().termsOfServiceItemText()),
                    trailing: InkWell(
                      onTap: () {
                        if (policyModel == null) {
                          showDialog(
                            context: context,
                            builder: (_) => const BaseDialog(
                              content: Text(AppStrings.termsLoadError),
                            ),
                          );
                          return;
                        }

                        context.goNamed(TermsAgreeDetailScreen.routeName,
                            extra: Tuple2(index, policyModel));
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
                    showDialog(
                        context: context,
                        builder: (_) => BaseDialog(
                            content: Text('${AppStrings.signInError}\n에러: ${e.toString()}')));
                  });
                },
                enabled: !termsAgreeState.map((e) => e.isAgree).toList().contains(false),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
