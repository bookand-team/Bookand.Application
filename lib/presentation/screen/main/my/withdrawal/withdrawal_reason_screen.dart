import 'package:bookand/core/const/revoke_type.dart';
import 'package:bookand/core/widget/base_app_bar.dart';
import 'package:bookand/core/widget/base_layout.dart';
import 'package:bookand/presentation/component/custom_dropdown.dart';
import 'package:bookand/presentation/provider/withdrawal_reason_provider.dart';
import 'package:bookand/presentation/screen/main/my/feedback_screen.dart';
import 'package:bookand/presentation/screen/main/my/newbookstorereport/new_bookstore_report_screen.dart';
import 'package:bookand/presentation/screen/main/my/terms_and_policy_screen.dart';
import 'package:bookand/presentation/screen/main/my/withdrawal/account_authentication_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/app_strings.dart';
import '../../../../component/round_rect_button.dart';

class WithdrawalReasonScreen extends ConsumerStatefulWidget {
  static String get routeName => 'withdrawalReasonScreen';

  const WithdrawalReasonScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<WithdrawalReasonScreen> createState() => _WithdrawalReasonScreenState();
}

class _WithdrawalReasonScreenState extends ConsumerState<WithdrawalReasonScreen> {
  final reasonTextController = TextEditingController();
  bool buttonEnabled = false;

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      appBar: const BaseAppBar(),
      child: Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom != 0 ? 20 : 56,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    AppStrings.withdrawalReasonTitle,
                    style: TextStyle(
                      color: Color(0xFF222222),
                      fontWeight: FontWeight.w600,
                      fontSize: 24,
                      letterSpacing: -0.02,
                    ),
                  ),
                  dropdown(context),
                  const SizedBox(height: 16),
                  guideWidget(),
                ],
              ),
            ),
            const SizedBox(height: 24),
            RoundRectButton(
              text: AppStrings.continuously,
              width: MediaQuery.of(context).size.width,
              height: 56,
              onPressed: () {
                if (ref.watch(withdrawalReasonStateNotifierProvider).revokeType != null) {
                  context.pushNamed(AccountAuthenticationScreen.routeName);
                }
              },
              enabled: buttonEnabled,
            ),
          ],
        ),
      ),
    );
  }

  Widget dropdown(BuildContext context) => Visibility(
      visible: MediaQuery.of(context).viewInsets.bottom == 0,
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: CustomDropdown(
          items: RevokeType.values
              .map((e) => DropdownMenuItem<RevokeType>(
                    onTap: () {
                      setState(() {
                        buttonEnabled = e != RevokeType.etc;
                      });
                    },
                    value: e,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text(
                        e.name,
                        style: const TextStyle(
                          color: Color(0xFF222222),
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          letterSpacing: -0.02,
                        ),
                      ),
                    ),
                  ))
              .toList(),
          value: ref.watch(withdrawalReasonStateNotifierProvider).revokeType,
          hint: AppStrings.defaultDropdownHint,
          onChanged: ref.watch(withdrawalReasonStateNotifierProvider.notifier).changeRevokeType,
        ),
      ));

  Widget guideWidget() {
    switch (ref.watch(withdrawalReasonStateNotifierProvider).revokeType) {
      case RevokeType.notEnoughContent:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              AppStrings.alternativeContentDissatisfaction1,
              style: TextStyle(
                color: Color(0xFF565656),
                fontWeight: FontWeight.w400,
                fontSize: 14,
                letterSpacing: -0.02,
              ),
            ),
            const SizedBox(height: 16),
            GestureDetector(
                onTap: () => context.goNamed(NewBookstoreReportScreen.routeName),
                child: const Text(
                  AppStrings.goNewBookstoreReport,
                  style: TextStyle(
                    color: Color(0xFFF86C30),
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    letterSpacing: -0.02,
                    decoration: TextDecoration.underline,
                    decorationColor: Color(0xFFF86C30),
                  ),
                )),
            const SizedBox(height: 20),
            const Text(
              AppStrings.alternativeContentDissatisfaction2,
              style: TextStyle(
                color: Color(0xFF565656),
                fontWeight: FontWeight.w400,
                fontSize: 14,
                letterSpacing: -0.02,
              ),
            ),
            const SizedBox(height: 16),
            GestureDetector(
                onTap: () => context.goNamed(FeedbackScreen.routeName),
                child: const Text(
                  AppStrings.goFeedback,
                  style: TextStyle(
                    color: Color(0xFFF86C30),
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    letterSpacing: -0.02,
                    decoration: TextDecoration.underline,
                    decorationColor: Color(0xFFF86C30),
                  ),
                )),
          ],
        );
      case RevokeType.uncomfortable:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              AppStrings.alternativeInconvenientToUse,
              style: TextStyle(
                color: Color(0xFF565656),
                fontWeight: FontWeight.w400,
                fontSize: 14,
                letterSpacing: -0.02,
              ),
            ),
            const SizedBox(height: 16),
            GestureDetector(
                onTap: () => context.goNamed(FeedbackScreen.routeName),
                child: const Text(
                  AppStrings.goFeedback,
                  style: TextStyle(
                    color: Color(0xFFF86C30),
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    letterSpacing: -0.02,
                    decoration: TextDecoration.underline,
                    decorationColor: Color(0xFFF86C30),
                  ),
                )),
          ],
        );
      case RevokeType.privacy:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              AppStrings.alternativePrivacyLeak,
              style: TextStyle(
                color: Color(0xFF565656),
                fontWeight: FontWeight.w400,
                fontSize: 14,
                letterSpacing: -0.02,
              ),
            ),
            const SizedBox(height: 16),
            GestureDetector(
                onTap: () => context.goNamed(TermsAndPolicyScreen.routeName),
                child: const Text(
                  AppStrings.goPrivacyPolicyCheck,
                  style: TextStyle(
                    color: Color(0xFFF86C30),
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    letterSpacing: -0.02,
                    decoration: TextDecoration.underline,
                    decorationColor: Color(0xFFF86C30),
                  ),
                )),
          ],
        );
      case RevokeType.etc:
        return Flexible(
          child: Container(
            height: MediaQuery.of(context).viewInsets.bottom != 0 ? double.infinity : 232,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFF222222)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextField(
              controller: reasonTextController,
              onChanged: (value) {
                ref.read(withdrawalReasonStateNotifierProvider).reason = value;
                setState(() {
                  buttonEnabled = value.isNotEmpty;
                });
              },
              decoration: const InputDecoration(
                hintText: AppStrings.defaultHint,
                hintStyle: TextStyle(
                  color: Color(0xFFACACAC),
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  letterSpacing: -0.02,
                ),
                errorBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                border: InputBorder.none,
              ),
              keyboardType: TextInputType.multiline,
              maxLines: null,
            ),
          ),
        );
      default:
        return const SizedBox();
    }
  }
}
