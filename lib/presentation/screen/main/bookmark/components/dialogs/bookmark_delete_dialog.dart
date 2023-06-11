import 'package:bookand/core/const/bookmark_type.dart';
import 'package:bookand/presentation/provider/bookmark/bookmark_article_provider.dart';
import 'package:bookand/presentation/provider/bookmark/bookmark_store_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class BookmarkDeleteDialog extends ConsumerWidget {
  final List<int> bookmarkIdList;
  final BookmarkType type;
  const BookmarkDeleteDialog(
      {Key? key, required this.bookmarkIdList, required this.type})
      : super(key: key);

  final TextStyle titleStyle = const TextStyle(fontSize: 18);
  final TextStyle contentStyle = const TextStyle(fontSize: 15);

  final Radius containerBr = const Radius.circular(18);
  final Radius buttonBr = const Radius.circular(8);

  final Color grey = const Color(0xffdddddd);

  final Size size = const Size(300, 220);
  final Size buttonSize = const Size(128, 40);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 32),
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.all(containerBr)),
      child: SizedBox(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding:
                  EdgeInsets.only(top: 50, right: 30, left: 30, bottom: 20),
              child: Column(
                children: [
                  Text(
                    "북마크를 삭제하시겠어요?",
                    style: TextStyle(
                      color: Color(0xff222222),
                      fontSize: 18,
                      fontFamily: "Pretendard",
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    "‘모아보기’에서 북마크를 삭제하면\n폴더에 저장된 북마크도 함께 삭제돼요.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xff999999),
                      fontSize: 15,
                      fontFamily: "Pretendard",
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      type == BookmarkType.article
                          ? ref
                              .read(bookmarkArticleNotifierProvider.notifier)
                              .delete(bookmarkIdList)
                          : ref
                              .read(bookmarkStoreNotifierProvider.notifier)
                              .delete(bookmarkIdList);
                      context.pop();
                    },
                    child: Container(
                      width: buttonSize.width,
                      height: buttonSize.height,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.all(buttonBr)),
                      child: Center(
                        child: Text(
                          '삭제할래요',
                          style: contentStyle.copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  GestureDetector(
                    onTap: () {
                      context.pop();
                    },
                    child: Container(
                      width: buttonSize.width,
                      height: buttonSize.height,
                      decoration: BoxDecoration(
                          color: grey,
                          borderRadius: BorderRadius.all(buttonBr)),
                      child: Center(
                        child: Text(
                          '아니요',
                          style: contentStyle.copyWith(color: Colors.black),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
