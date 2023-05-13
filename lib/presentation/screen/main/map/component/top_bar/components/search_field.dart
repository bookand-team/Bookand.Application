import 'package:bookand/presentation/provider/map/map_bools_providers.dart';
import 'package:bookand/presentation/screen/main/map/component/search_screen/map_search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SearchField extends ConsumerWidget {
  const SearchField({Key? key}) : super(key: key);

  final double bRadius = 8;
  final double padding = 10;
  final Color greyColor = const Color(0xffacacac);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () =>
          ref.context.pushNamed(MapSearchScreen.routeName).then((value) {
        if (value == 'showhide') {
          ref
              .read(hideStoreToggleProvider.notifier)
              .activate(ref: ref, context: context);
        }
      }),
      child: Container(
        padding: EdgeInsets.all(padding),
        decoration: BoxDecoration(
            border: Border.all(color: greyColor),
            borderRadius: BorderRadius.all(Radius.circular(bRadius))),
        width: 320,
        child: Row(
          children: [
            const Text('궁금한 서점/지역을 검색해 보세요'),
            const Spacer(),
            Icon(
              Icons.search,
              color: greyColor,
            ),
          ],
        ),
      ),
    );
  }
}
