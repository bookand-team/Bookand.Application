import 'package:bookand/domain/model/article/article_detail.dart';
import 'package:bookand/domain/model/bookstore/bookstore_detail.dart';
import 'package:bookand/presentation/screen/main/bookmark/components/content_components/article_con.dart';
import 'package:bookand/presentation/screen/main/bookmark/components/content_components/bookstore_con.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BookmarkContents extends ConsumerWidget {
  final List<dynamic> dataList;
  const BookmarkContents({Key? key, required this.dataList}) : super(key: key);

  final TextStyle titleStyle =
      const TextStyle(fontSize: 18, color: Color(0xff222222));
  final TextStyle settingStyle = const TextStyle(
    fontSize: 12,
  );
  final TextStyle noContentDes = const TextStyle(
    fontSize: 14,
  );

  final Color grey = const Color(0xffdddddd);

  final double noContentHeight = 140;
  final Size settingSize = const Size(56, 24);
  final double settingIconSize = 12;

  final Size warningSize = const Size(36, 36);

  final warningPath = 'assets/images/map/ic_warning.png';
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isEmpty = dataList.isEmpty;
    return isEmpty
        ? SizedBox(
            height: noContentHeight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  warningPath,
                  width: warningSize.width,
                  height: warningSize.height,
                ),
                const Spacer(
                  flex: 2,
                ),
                Text(
                  '북마크한 서점이 없어요',
                  style: titleStyle,
                ),
                const Spacer(
                  flex: 1,
                ),
                Text(
                  '북마크 기능을 이용해\n나만의 리스트를 만들어보세요!',
                  style: noContentDes.copyWith(color: grey),
                ),
              ],
            ),
          )
        : Column(
            children: [
              Row(
                children: [
                  Text(
                    '모아보기',
                    style: titleStyle,
                  ),
                  Container(
                    width: settingSize.width,
                    height: settingSize.height,
                    decoration: BoxDecoration(
                        border: Border.all(color: grey),
                        borderRadius: BorderRadius.circular(32)),
                    child: Row(
                      children: [
                        Icon(
                          Icons.settings_outlined,
                          color: grey,
                          size: settingIconSize,
                        ),
                        Text(
                          '편집',
                          style: settingStyle.copyWith(color: grey),
                        )
                      ],
                    ),
                  )
                ],
              ),
              GridView.count(
                crossAxisCount: 2,
                children: [
                  ...dataList.map((e) {
                    if (e is BookstoreDetail) {
                      return BookstoreCon(bookstore: e);
                    } else if (e is ArticleDetail) {
                      return ArticleCon(article: e);
                    } else {
                      return const SizedBox();
                    }
                  }).toList()
                ],
              )
            ],
          );
  }
}
