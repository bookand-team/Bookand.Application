import 'package:bookand/core/const/bookmark_type.dart';
import 'package:bookand/domain/model/bookmark/bookmark_model.dart';
import 'package:bookand/gen/assets.gen.dart';
import 'package:bookand/presentation/provider/bookmark/bookmark_edit_provider.dart';
import 'package:bookand/presentation/provider/bookmark/bookmark_type_provider.dart';
import 'package:bookand/presentation/screen/main/bookmark/components/content_components/bookmark_container.dart';
import 'package:bookand/presentation/screen/main/bookmark/components/content_components/edit_sheet_button.dart';
import 'package:bookand/presentation/screen/main/home/article_screen.dart';
import 'package:bookand/presentation/screen/main/home/bookstore_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

/// 북마크 페이지의 모아보기에서 북마크들을 표시하는 위젯
class BookmarkContents extends ConsumerWidget {
  final BookmarkType type;
  final List<BookmarkModel> bookmarkList;
  final ScrollController scrollController;

  const BookmarkContents(
      {Key? key, required this.type, required this.bookmarkList, required this.scrollController})
      : super(key: key);

  final TextStyle titleStyle = const TextStyle(
    color: Color(0xff222222),
    fontSize: 18,
    fontFamily: "Pretendard",
    fontWeight: FontWeight.w700,
  );
  final TextStyle settingStyle = const TextStyle(
    fontSize: 12,
  );
  final TextStyle noContentDes = const TextStyle(
    fontSize: 14,
  );

  final Color grey = const Color(0xffacacac);

  final double noContentHeight = 180;
  final Size settingSize = const Size(56, 24);
  final double settingIconSize = 12;

  final Size warningSize = const Size(36, 36);

  final warningPath = 'assets/images/map/ic_warning.png';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool settingMode = ref.watch(bookmarkEditNotifierProvider);
    bool isEmpty = bookmarkList.isEmpty;
    // 테스트
    return isEmpty
        ? SizedBox(
            height: noContentHeight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 30,
                ),
                SvgPicture.asset(Assets.images.icWarning,
                    width: warningSize.width, height: warningSize.height),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  '북마크한 서점이 없어요',
                  style: titleStyle,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 12,
                ),
                Text(
                  '북마크 기능을 이용해\n나만의 리스트를 만들어보세요!',
                  textAlign: TextAlign.center,
                  style: noContentDes.copyWith(color: grey),
                ),
              ],
            ),
          )
        : Padding(
            padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '모아보기',
                      style: titleStyle,
                    ),
                    const EditSheetButton()
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                GridView.builder(
                  controller: scrollController,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio:
                          BookmarkContainer.size.width / BookmarkContainer.size.height),
                  shrinkWrap: true,
                  itemCount: bookmarkList.length,
                  itemBuilder: (context, index) {
                    return BookmarkContainer(
                        model: bookmarkList[index],
                        onTap: () {
                          ref.read(bookmarkTypeNotifierProvider) == BookmarkType.article
                              ? context.pushNamed(ArticleScreen.routeName,
                                  pathParameters: {'id': bookmarkList[index].bookmarkId.toString()},
                                  queryParameters: {'showCloseButton': 'true'})
                              : context.goNamed(
                                  BookstoreScreen.routeName,
                                  pathParameters: {'id': bookmarkList[index].bookmarkId.toString()},
                                );
                        },
                        settingMode: settingMode);
                  },
                )
              ],
            ),
          );
  }
}
