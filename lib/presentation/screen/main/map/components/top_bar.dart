import 'package:bookand/presentation/provider/map_state_proivders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'search_field.dart';
import 'search_buttons/search_buttons.dart';

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
              const MarkButton(),
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
