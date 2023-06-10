//providers
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'components/hide_book_store_button.dart';
import 'components/map_book_mark_button.dart';
//components
import 'components/search_field.dart';
import 'components/theme_button.dart';

class MapBarLong extends ConsumerWidget implements PreferredSizeWidget {
  const MapBarLong({Key? key}) : super(key: key);

  static double height = 103;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 4),
      // height: 108,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const SearchField(),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              const MapBookMarkButton(),
              const SizedBox(
                width: 8,
              ),
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
  Size get preferredSize => Size(double.infinity, MapBarLong.height);
}
