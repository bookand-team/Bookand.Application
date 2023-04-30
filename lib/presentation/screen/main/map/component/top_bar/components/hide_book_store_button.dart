import 'package:bookand/presentation/provider/map/map_bools_providers.dart';
import 'package:bookand/presentation/provider/map/map_button_height_provider.dart';
import 'package:bookand/presentation/provider/map/map_panel_visible_provider.dart';
import 'package:flutter/material.dart';
//providers
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'hide_book_store_bottom_sheet.dart';

class HideBookStoreButton extends ConsumerWidget {
  const HideBookStoreButton({Key? key}) : super(key: key);

  final double bRauius = 15;
  final Size size = const Size(80, 28);
  final double margin = 5;
  final double horiPadding = 12;
  final double vertPadding = 5;
  final Color grey = const Color(0xffdddddd);
  final TextStyle textStyle = const TextStyle(fontSize: 12);
  final TextStyle hideTitle = const TextStyle(
      fontSize: 18, fontWeight: FontWeight.w700, color: Color(0xff222222));

  final bottomSheetPadding =
      const EdgeInsets.symmetric(horizontal: 15, vertical: 5);
  final bottomSheetBr = const Radius.circular(24);
  final double bottomSheetHeight = 350;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void showHideStore() {
      ref.read(mapPanelVisibleNotifierProvider.notifier).close();
      ref.read(mapButtonHeightNotifierProvider.notifier).toHideBottomSheet();
      showModalBottomSheet(
        useSafeArea: true,
        useRootNavigator: true,
        isScrollControlled: true,
        barrierColor: Colors.transparent,
        backgroundColor: Colors.white,
        context: context,
        builder: (context) {
          return const HideBookStoreBottomSheet();
        },
      ).then((value) {
        ref.read(hideStoreToggleProvider.notifier).toggle();
        ref.read(mapButtonHeightNotifierProvider.notifier).toBottom();
      });
    }

    final bool selected = ref.watch(hideStoreToggleProvider);
    final con = ref.read(hideStoreToggleProvider.notifier);
    return GestureDetector(
        onTap: () {
          if (!selected) {
            showHideStore();
          }
          con.toggle();
        },
        child: Container(
          margin: EdgeInsets.all(margin),
          height: size.height,
          padding: EdgeInsets.symmetric(
              vertical: vertPadding, horizontal: horiPadding),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: selected ? Colors.black : grey),
              borderRadius: BorderRadius.all(Radius.circular(bRauius))),
          child: Row(
            children: [
              Text(
                '✨ 숨은 서점',
                style: textStyle,
              ),
            ],
          ),
        ));
  }
}
