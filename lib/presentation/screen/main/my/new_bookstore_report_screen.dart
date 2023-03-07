import 'package:bookand/presentation/provider/kakao_search_keyword_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/widget/base_app_bar.dart';
import '../../../../core/widget/base_layout.dart';
import '../../../component/round_rect_button.dart';

class NewBookstoreReportScreen extends ConsumerWidget {
  static String get routeName => 'newBookstoreReportScreen';

  const NewBookstoreReportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BaseLayout(
      resizeToAvoidBottomInset: false,
      appBar: const BaseAppBar(
        title: '새로운 서점 제보',
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 56),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '어떤 서점의\n이야기가 궁금하신가요?',
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
                    child: TextField(
                      decoration: const InputDecoration(
                        hintText: '궁금한 서점을 검색해 보세요',
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
                      onChanged: (value) {
                        ref.read(kakaoSearchKeywordStateNotifierProvider.notifier).query = value;
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  InkWell(
                    onTap: () {
                      ref.read(kakaoSearchKeywordStateNotifierProvider.notifier).searchKeyword();
                    },
                    child: SvgPicture.asset('assets/images/ic_search.svg'),
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    final item = ref.read(kakaoSearchKeywordStateNotifierProvider)[index];
                    return ListTile(
                      title: Text(item.placeName),
                      subtitle: Text(item.roadAddressName),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider(
                      thickness: 1,
                      height: 0,
                      color: Color(0xFFF5F5F5),
                    );
                  },
                  itemCount: ref.watch(kakaoSearchKeywordStateNotifierProvider).length),
            ),
            RoundRectButton(
              text: '제보하기',
              width: MediaQuery.of(context).size.width,
              height: 56,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
