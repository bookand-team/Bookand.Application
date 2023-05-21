// ignore_for_file: non_constant_identifier_names

import 'package:bookand/core/const/bookmark_type.dart';
import 'package:bookand/presentation/provider/bookmark/bookmark_type_provider.dart';
import 'package:bookand/presentation/screen/main/bookmark/bookmark_style.dart';
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
      required void Function() ontap}) {
    return Padding(
      padding: pagePadding,
      child: GestureDetector(
        onTap: ontap,
        child: Text(
          data,
          style: buttonStyle.copyWith(
              color: isActive ? selectedColor : unselectedColor),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        createButton(
          data: BOOKSTORE,
          isActive: type == BookmarkType.bookstore,
          ontap: () {
            ref.read(bookmarkTypeNotifierProvider.notifier).toBookstore();
          },
        ),
        Text(
          '/',
          style: buttonStyle.copyWith(color: unselectedColor),
        ),
        createButton(
          data: ARTICLE,
          isActive: type == BookmarkType.article,
          ontap: () {
            ref.read(bookmarkTypeNotifierProvider.notifier).toArticle();
          },
        ),
      ],
    );
  }
}
