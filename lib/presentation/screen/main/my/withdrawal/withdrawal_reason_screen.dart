import 'package:bookand/core/const/revoke_type.dart';
import 'package:bookand/core/widget/base_app_bar.dart';
import 'package:bookand/core/widget/base_layout.dart';
import 'package:bookand/presentation/provider/withdrawal_reason_provider.dart';
import 'package:bookand/presentation/screen/main/my/feedback_screen.dart';
import 'package:bookand/presentation/screen/main/my/new_bookstore_report_screen.dart';
import 'package:bookand/presentation/screen/main/my/terms_and_policy_screen.dart';
import 'package:bookand/presentation/screen/main/my/withdrawal/account_authentication_screen.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
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
  bool isOpenDropdown = false;
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
                  Visibility(
                      visible: MediaQuery.of(context).viewInsets.bottom == 0,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: dropdown(),
                      )),
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

  List<DropdownMenuItem<RevokeType>> addDividerAfterItems() {
    List<DropdownMenuItem<RevokeType>> menuItems = [];
    const items = RevokeType.values;
    for (var item in items) {
      menuItems.addAll([
        DropdownMenuItem<RevokeType>(
          onTap: () {
            setState(() {
              if (item == RevokeType.etc) {
                buttonEnabled = false;
              } else {
                buttonEnabled = true;
              }
            });
          },
          value: item,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              item.name,
              style: const TextStyle(
                color: Color(0xFF222222),
                fontWeight: FontWeight.w400,
                fontSize: 14,
                letterSpacing: -0.02,
              ),
            ),
          ),
        ),
        if (item != items.last)
          const DropdownMenuItem(
            enabled: false,
            child: Divider(
              height: 0,
              color: Color(0xFF222222),
            ),
          )
      ]);
    }
    return menuItems;
  }

  Widget dropdown() => DropdownButton2<RevokeType>(
        value: ref.watch(withdrawalReasonStateNotifierProvider).revokeType,
        hint: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            AppStrings.defaultDropdownHint,
            style: TextStyle(
              color: Color(0xFFACACAC),
              fontWeight: FontWeight.w400,
              fontSize: 14,
              letterSpacing: -0.02,
            ),
          ),
        ),
        items: addDividerAfterItems(),
        onChanged: (value) {
          ref.watch(withdrawalReasonStateNotifierProvider.notifier).changeWithdrawalReason(
                revokeType: value,
                reason: reasonTextController.text,
              );
        },
        onMenuStateChange: (value) {
          setState(() {
            isOpenDropdown = value;
          });
        },
        underline: const SizedBox(),
        buttonStyleData: ButtonStyleData(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFF222222)),
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(8),
              topRight: const Radius.circular(8),
              bottomLeft: Radius.circular(isOpenDropdown ? 0 : 8),
              bottomRight: Radius.circular(isOpenDropdown ? 0 : 8),
            ),
          ),
        ),
        iconStyleData: IconStyleData(
          icon: Padding(
            padding: const EdgeInsets.only(right: 12),
            child: SvgPicture.asset(
              'assets/images/my/ic_drawer_open.svg',
            ),
          ),
          openMenuIcon: Padding(
            padding: const EdgeInsets.only(right: 12),
            child: SvgPicture.asset(
              'assets/images/my/ic_drawer_close.svg',
            ),
          ),
        ),
        dropdownStyleData: DropdownStyleData(
          width: MediaQuery.of(context).size.width - 32,
          padding: EdgeInsets.zero,
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFF222222)),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(8),
              bottomRight: Radius.circular(8),
            ),
          ),
          elevation: 0,
        ),
        menuItemStyleData: MenuItemStyleData(
          customHeights: List.generate(
            addDividerAfterItems().length,
            (index) => index % 2 == 0 ? 46.0 : 0.0,
          ),
          padding: EdgeInsets.zero,
        ),
      );
}
