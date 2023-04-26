import 'package:bookand/core/widget/base_dialog.dart';
import 'package:bookand/domain/model/kakao/search_keyword_response.dart';
import 'package:bookand/domain/usecase/bookstore_report_use_case.dart';
import 'package:bookand/presentation/provider/new_bookstore_report_provider.dart';
import 'package:bookand/presentation/screen/main/my/new_bookstore_report_success.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/app_strings.dart';
import '../../../../core/widget/base_app_bar.dart';
import '../../../../core/widget/base_layout.dart';
import '../../../component/round_rect_button.dart';

class NewBookstoreReportScreen extends ConsumerStatefulWidget {
  static String get routeName => 'newBookstoreReportScreen';

  const NewBookstoreReportScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<NewBookstoreReportScreen> createState() => _NewBookstoreReportScreenState();
}

class _NewBookstoreReportScreenState extends ConsumerState<NewBookstoreReportScreen> {
  final scrollController = ScrollController();
  final searchTextController = TextEditingController();

  @override
  void initState() {
    searchTextController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final newBookstoreReportProvider = ref.watch(newBookstoreReportStateNotifierProvider.notifier);
    final newBookstoreReportState = ref.watch(newBookstoreReportStateNotifierProvider);

    return BaseLayout(
      resizeToAvoidBottomInset: false,
      appBar: const BaseAppBar(
        title: AppStrings.newBookstoreReportAppBarTitle,
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 56),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              AppStrings.newBookstoreReportTitle,
              style: TextStyle(
                color: Color(0xFF222222),
                fontWeight: FontWeight.w600,
                fontSize: 24,
                letterSpacing: -0.02,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(12),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F7),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: searchTextController,
                      decoration: const InputDecoration(
                        hintText: AppStrings.bookstoreSearchHint,
                        hintStyle: TextStyle(
                          color: Color(0xFFACACAC),
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          letterSpacing: -0.02,
                        ),
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                        errorBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        focusedErrorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        border: InputBorder.none,
                      ),
                      textInputAction: TextInputAction.search,
                      onChanged: newBookstoreReportProvider.onSearchTextChanged,
                      onFieldSubmitted: (_) {
                        newBookstoreReportProvider.searchKeyword(searchTextController.text);
                        scrollController.jumpTo(0);
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  InkWell(
                    onTap: () {
                      if (searchTextController.text.isNotEmpty) {
                        searchTextController.text = '';
                        newBookstoreReportProvider.resetSearchResult();
                      }
                    },
                    child: SvgPicture.asset(
                      searchTextController.text.isEmpty
                          ? 'assets/images/ic_search.svg'
                          : 'assets/images/ic_delete.svg',
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Visibility(
              visible: newBookstoreReportProvider.searchKeywordResp != null,
              child: const Text(
                AppStrings.searchResult,
                style: TextStyle(
                  color: Color(0xFF565656),
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  letterSpacing: -0.02,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 16, bottom: 13),
                child: Builder(
                  builder: (context) {
                    return newBookstoreReportProvider.hasSearchResult()
                        ? searchResultNotFoundWidget()
                        : Scrollbar(
                            controller: scrollController,
                            child: ListView.separated(
                              physics: const ClampingScrollPhysics(),
                              controller: scrollController,
                              itemBuilder: (context, index) {
                                if (index < newBookstoreReportState.searchList.length) {
                                  final item = newBookstoreReportState.searchList[index];
                                  final searchKeyword =
                                      newBookstoreReportProvider.currentSearchKeyword;
                                  return searchResultItemTile(
                                    item: item,
                                    searchKeyword: searchKeyword,
                                    isSelected: newBookstoreReportProvider.isSelectedItem(item.id),
                                    onTap: () {
                                      newBookstoreReportProvider.onTapSelectItem(item.id);
                                    },
                                  );
                                }

                                if (newBookstoreReportProvider.isEnd()) {
                                  return const SizedBox();
                                } else {
                                  newBookstoreReportProvider.nextSearchKeyword();
                                  return const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 20),
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  );
                                }
                              },
                              separatorBuilder: (context, index) {
                                return const Divider(
                                  thickness: 1,
                                  height: 0,
                                  color: Color(0xFFF5F5F5),
                                );
                              },
                              itemCount: newBookstoreReportState.searchList.length + 1,
                            ),
                          );
                  },
                ),
              ),
            ),
            RoundRectButton(
              text: AppStrings.reporting,
              width: MediaQuery.of(context).size.width,
              height: 56,
              enabled: newBookstoreReportState.selectedId.isNotEmpty,
              onPressed: () async {
                final selectedItem = newBookstoreReportState.searchList
                    .firstWhere((e) => e.id == newBookstoreReportState.selectedId);

                await ref
                    .read(bookstoreReportUseCaseProvider)
                    .bookstoreReport(
                        name: selectedItem.placeName, address: selectedItem.roadAddressName)
                    .then((_) {
                  context.goNamed(NewBookstoreReportSuccessScreen.routeName);
                }, onError: (e) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return BaseDialog(content: Text(e.toString()));
                    },
                  );
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget searchResultNotFoundWidget() => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/images/ic_warning.svg'),
            const SizedBox(
              height: 16,
            ),
            const Text(
              AppStrings.noBookstoreSearchResult,
              style: TextStyle(
                color: Color(0xFF222222),
                fontWeight: FontWeight.w500,
                fontSize: 18,
                letterSpacing: -0.02,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            const Text(
              AppStrings.noBookstoreSearchResultDescription,
              style: TextStyle(
                color: Color(0xFF565656),
                fontWeight: FontWeight.w500,
                fontSize: 14,
                letterSpacing: -0.02,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );

  Widget searchResultItemTile(
          {required SearchKeywordDocument item,
          required String searchKeyword,
          required bool isSelected,
          required Function() onTap}) =>
      InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: onTap,
        child: ListTile(
          title: RichText(
            text: TextSpan(
              style: const TextStyle(
                color: Color(0xFF222222),
                fontWeight: FontWeight.w400,
                fontSize: 14,
                letterSpacing: -0.02,
              ),
              children: getEmphasisAppliedSpans(
                text: item.placeName,
                emphasisText: searchKeyword,
                emphasisTextStyle: const TextStyle(
                  color: Color(0xFF346FC9),
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  letterSpacing: -0.02,
                ),
              ),
            ),
          ),
          subtitle: Text(
            item.roadAddressName,
            style: const TextStyle(
              color: Color(0xFFACACAC),
              fontWeight: FontWeight.w400,
              fontSize: 12,
              letterSpacing: -0.02,
            ),
          ),
          trailing: SvgPicture.asset(
            isSelected
                ? 'assets/images/ic_all_check_active.svg'
                : 'assets/images/ic_all_check_inactive.svg',
            width: 26,
            height: 26,
          ),
          dense: true,
          contentPadding: EdgeInsets.zero,
        ),
      );

  List<TextSpan> getEmphasisAppliedSpans({
    required String text,
    required String emphasisText,
    required TextStyle emphasisTextStyle,
  }) {
    if (emphasisText.isEmpty) return [TextSpan(text: text)];

    List<TextSpan> spans = [];
    int spanBoundary = 0;

    do {
      final startIdx = text.indexOf(emphasisText, spanBoundary);

      if (startIdx == -1) {
        spans.add(TextSpan(text: text.substring(spanBoundary)));
        return spans;
      }

      if (startIdx > spanBoundary) {
        spans.add(TextSpan(text: text.substring(spanBoundary, startIdx)));
      }

      final endIdx = startIdx + emphasisText.length;
      final spanText = text.substring(startIdx, endIdx);
      spans.add(TextSpan(text: spanText, style: emphasisTextStyle));

      spanBoundary = endIdx;
    } while (spanBoundary < text.length);

    return spans;
  }
}
