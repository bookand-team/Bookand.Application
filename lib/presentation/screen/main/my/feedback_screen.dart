import 'package:bookand/presentation/component/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
    final feedbackState = ref.watch(feedbackNotifierProvider);
    final feedbackProvider = ref.watch(feedbackNotifierProvider.notifier);

    return BaseLayout(
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
                      child: CustomDropdown<FeedbackTarget>(
                        items: FeedbackTarget.values
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
                        hint: '피드백 유형을 선택해주세요',
                        onChanged: feedbackProvider.changeFeedbackTarget,
                      ),
                    )),
                Visibility(
                    visible: feedbackState.feedbackTarget != null &&
                        MediaQuery.of(context).viewInsets.bottom == 0,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: CustomDropdown<FeedbackType>(
                        items: getFeedbackTypeList(feedbackState.feedbackTarget)
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
                        hint: '대상 화면을 선택해주세요',
                        onChanged: feedbackProvider.changeFeedbackType,
                      ),
                    )),
                Container(
                  height: 232,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFF222222)),
                    borderRadius: BorderRadius.circular(8),
                  ),
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
                const SizedBox(height: 24),
                RoundRectButton(
                  text: '의견 보내기',
                  width: MediaQuery.of(context).size.width,
                  height: 56,
                  onPressed: () {
                    feedbackProvider.sendFeedback();
                  },
                  enabled: (feedbackState.reason?.isNotEmpty ?? false) &&
                      feedbackState.feedbackTarget != null &&
                      feedbackState.feedbackType != null,
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
                '소중한 의견으로\n성장하는 북앤드입니다',
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
            '북앤드의 성장에 날개를 달아주세요',
            style: TextStyle(
              color: Color(0xFF565656),
              fontWeight: FontWeight.w400,
              fontSize: 14,
              letterSpacing: -0.02,
            ),
          ),
        ],
      );

  List<FeedbackType> getFeedbackTypeList(FeedbackTarget? feedbackTarget) {
    if (feedbackTarget == null) return [];

    final infoTypeList = [FeedbackType.article, FeedbackType.bookstore];

    if (feedbackTarget == FeedbackTarget.information) {
      return infoTypeList;
    }

    final typeList = <FeedbackType>[];
    for (var element in FeedbackType.values) {
      if (infoTypeList.contains(element)) continue;
      typeList.add(element);
    }

    return typeList;
  }
}
