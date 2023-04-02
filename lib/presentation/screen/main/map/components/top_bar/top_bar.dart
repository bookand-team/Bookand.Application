import 'package:flutter/material.dart';

//components
import 'components/search_field.dart';
import 'components/hide_book_store_button.dart';
import 'components/book_mark_button.dart';
import 'components/theme_button.dart';
//providers
import 'package:bookand/presentation/provider/map/map_bools_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TopBar extends ConsumerWidget {
  const TopBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchBarShow = ref.watch(searchBarShowProvider);
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: searchBarShow
              ? [
                  const BoxShadow(
                      blurRadius: 1, spreadRadius: 1, color: Colors.grey)
                ]
              : null),
      padding: const EdgeInsets.all(10),
      // height: 108,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          searchBarShow ? const SearchField() : const SizedBox(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const BookMarkButton(),
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
}
