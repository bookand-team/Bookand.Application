import 'package:bookand/core/widget/base_dialog.dart';
import 'package:bookand/presentation/component/custom_dropdown.dart';
import 'package:bookand/presentation/screen/main/my/thank_you_opinion_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/app_strings.dart';
import '../../../../core/const/feedback_target.dart';
import '../../../../core/const/feedback_type.dart';
import '../../../../core/widget/base_app_bar.dart';
import '../../../../core/widget/base_layout.dart';
import '../../../component/round_rect_button.dart';
import '../../../provider/feedback_provider.dart';

class FeedbackScreen extends ConsumerWidget {
  static String get routeName => 'feedbackScreen';

  const FeedbackScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final feedbackState = ref.watch(feedbackNotifierProvider).feedback;
    final feedbackProvider = ref.watch(feedbackNotifierProvider.notifier);

    return BaseLayout(
      isLoading: feedbackProvider.isLoading,
      appBar: const BaseAppBar(title: AppStrings.feedback),
      child: Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom != 0 ? 20 : 56,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            headerWidget(context),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Visibility(
                    visible: MediaQuery.of(context).viewInsets.bottom == 0,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: CustomDropdown<FeedbackType>(
                        items: FeedbackType.values
                            .map((e) => DropdownMenuItem<FeedbackType>(
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
                        value: feedbackState.feedbackType,
                        hint: AppStrings.feedbackTypeHint,
                        onChanged: feedbackProvider.changeFeedbackType,
                      ),
                    )),
                Visibility(
                    visible: feedbackState.feedbackType != null &&
                        feedbackState.feedbackType != FeedbackType.push &&
                        MediaQuery.of(context).viewInsets.bottom == 0,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: CustomDropdown<FeedbackTarget>(
                        items: getFeedbackTargetList(feedbackState.feedbackType)
                            .map((e) => DropdownMenuItem<FeedbackTarget>(
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
                        value: feedbackState.feedbackTarget,
                        hint: AppStrings.feedbackTargetHint,
                        onChanged: feedbackProvider.changeFeedbackTarget,
                      ),
                    )),
                Container(
                  height: 232,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFF222222)),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Scrollbar(
                    controller: ScrollController(),
                    child: TextField(
                      onChanged: feedbackProvider.changeReason,
                      decoration: const InputDecoration(
                        hintText: AppStrings.defaultHint,
                        hintStyle: TextStyle(
                          color: Color(0xFFACACAC),
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          letterSpacing: -0.02,
                        ),
                        counterText: '',
                        errorBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        focusedErrorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        border: InputBorder.none,
                      ),
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      maxLength: 1000,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                RoundRectButton(
                  text: AppStrings.sendFeedback,
                  width: MediaQuery.of(context).size.width,
                  height: 56,
                  onPressed: () {
                    feedbackProvider.sendFeedback(
                      onSuccess: () {
                        context.goNamed(ThankYouOpinionScreen.routeName);
                      },
                      onError: () {
                        showDialog(
                          context: context,
                          builder: (_) => const BaseDialog(
                            content: Text(AppStrings.feedbackSendError),
                          ),
                        );
                      },
                    );
                  },

                  /// 내용이 있고,
                  /// 피드백 대상과 유형이 null이 아니거나,
                  /// 피드백 대상이 null이고, 피드백 유형이 push 일 때,
                  /// 버튼이 활성화 됨.
                  enabled: feedbackState.content?.isNotEmpty == true &&
                      ((feedbackState.feedbackTarget != null &&
                              feedbackState.feedbackType != null) ||
                          (feedbackState.feedbackTarget == null &&
                              feedbackState.feedbackType == FeedbackType.push)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget headerWidget(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: MediaQuery.of(context).viewInsets.bottom == 0,
            child: const Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Text(
                AppStrings.feedbackTitle,
                style: TextStyle(
                  color: Color(0xFF222222),
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                  letterSpacing: -0.02,
                ),
              ),
            ),
          ),
          const Text(
            AppStrings.feedbackSubTitle,
            style: TextStyle(
              color: Color(0xFF565656),
              fontWeight: FontWeight.w400,
              fontSize: 14,
              letterSpacing: -0.02,
            ),
          ),
        ],
      );

  List<FeedbackTarget> getFeedbackTargetList(FeedbackType? feedbackType) {
    if (feedbackType == null) return [];

    final infoTypeList = [FeedbackTarget.article, FeedbackTarget.bookstore];

    if (feedbackType == FeedbackType.information) {
      return infoTypeList;
    }

    final typeList = <FeedbackTarget>[];
    for (var element in FeedbackTarget.values) {
      if (infoTypeList.contains(element)) continue;
      typeList.add(element);
    }

    return typeList;
  }
}
