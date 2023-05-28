//providers
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'components/hide_book_store_button.dart';
import 'components/map_book_mark_button.dart';
import 'components/theme_button.dart';

class MapBarShort extends ConsumerWidget implements PreferredSizeWidget {
  const MapBarShort({Key? key}) : super(key: key);

  static double height = 80;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        const BoxShadow(blurRadius: 1, spreadRadius: 1, color: Colors.grey)
      ]),
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 4),
      // height: 108,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const MapBookMarkButton(),
              const ThemeButton(),
              const Spacer(),
              Container(
                margin: const EdgeInsets.all(10),
                width: 1,
                height: 16,
                color: const Color(0xffdddddd),
              ),
              const HideBookStoreButton()
            ],
          )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size(double.infinity, MapBarShort.height);
}
