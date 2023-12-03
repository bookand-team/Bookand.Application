// ignore_for_file: non_constant_identifier_names

import 'package:bookand/core/const/bookmark_type.dart';
import 'package:bookand/presentation/provider/bookmark/bookmark_edit_provider.dart';
import 'package:bookand/presentation/provider/bookmark/bookmark_eidt_list.dart';
import 'package:bookand/presentation/provider/bookmark/bookmark_type_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BookmarkTop extends ConsumerWidget {
  final BookmarkType type;
  const BookmarkTop({Key? key, required this.type}) : super(key: key);

  final TextStyle buttonStyle =
      const TextStyle(fontSize: 22, fontWeight: FontWeight.bold);
  final selectedColor = const Color(0xff222222);
  final unselectedColor = const Color(0xffDDDDDD);

  final String BOOKSTORE = '서점';
  final String ARTICLE = '아티클';

  Widget createButton(
      {required bool isActive,
      required String data,
      required void Function() ontap,
      required bool isLeft}) {
    return Padding(
      padding: isLeft
          ? const EdgeInsets.fromLTRB(0, 0, 8, 12)
          : const EdgeInsets.fromLTRB(8, 0, 0, 12),
      child: GestureDetector(
        onTap: ontap,
        child: Text(data,
            style: TextStyle(
              color: isActive ? selectedColor : unselectedColor,
              fontSize: 22,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w700,
              letterSpacing: -0.44,
            )),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      width: MediaQuery.of(context).size.width,
      height: 64,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          createButton(
            isLeft: true,
            data: BOOKSTORE,
            isActive: type == BookmarkType.bookstore,
            ontap: () {
              ref.read(bookmarkTypeNotifierProvider.notifier).toBookstore();
              ref.read(bookmarkEditNotifierProvider.notifier).editOff();
              ref
                  .read(bookmarkEditNotifierProvider.notifier)
                  .closeBottomSheet();
              ref.read(bookmarkEditListNotifierProvider.notifier).clear();
            },
          ),
          const Padding(
            padding: EdgeInsets.only(bottom: 12),
            child: Text(
              '/',
              style: TextStyle(
                color: Color(0xFFDDDDDD),
                fontSize: 22,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          createButton(
            isLeft: false,
            data: ARTICLE,
            isActive: type == BookmarkType.article,
            ontap: () {
              ref.read(bookmarkTypeNotifierProvider.notifier).toArticle();
              ref.read(bookmarkEditNotifierProvider.notifier).editOff();
              ref
                  .read(bookmarkEditNotifierProvider.notifier)
                  .closeBottomSheet();
              ref.read(bookmarkEditListNotifierProvider.notifier).clear();
            },
          ),
        ],
      ),
    );
  }
}
