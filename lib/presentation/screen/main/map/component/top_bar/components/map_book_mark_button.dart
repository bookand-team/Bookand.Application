import 'package:bookand/presentation/provider/map/bools/map_bookmark_toggle.dart';
import 'package:bookand/presentation/provider/map/map_bookstores_provider.dart';
import 'package:bookand/presentation/provider/map/widget_marker_provider.dart';
import 'package:flutter/material.dart';
//providers
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MapBookMarkButton extends ConsumerWidget {
  const MapBookMarkButton({Key? key}) : super(key: key);

  final double bRauius = 15;
  final Size size = const Size(55, 28);
  final double horiPadding = 12;
  final double vertPadding = 5;
  final Color grey = const Color(0xffdddddd);
  final Color selectedColor = const Color(0xfff86c30);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(bookMarkToggleNotifierProvider);
    final con = ref.read(bookMarkToggleNotifierProvider.notifier);

    return GestureDetector(
        onTap: () {
          if (selected) {
            con.deactivate();
            ref
                .read(mapBookStoreNotifierProvider.notifier)
                .filteredBookstores();

            ref
                .read(widgetMarkerNotiferProvider.notifier)
                .setBookstoreMarker(ref.read(mapBookStoreNotifierProvider));
          } else {
            con.activate();
            ref
                .read(mapBookStoreNotifierProvider.notifier)
                .filteredBookstores();
            ref
                .read(widgetMarkerNotiferProvider.notifier)
                .setBookmarkedStore(ref.read(mapBookStoreNotifierProvider));
          }
        },
        child: Container(
          // width: size.width,
          height: size.height,
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(
              vertical: vertPadding, horizontal: horiPadding),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: selected ? selectedColor : grey),
              borderRadius: BorderRadius.all(Radius.circular(bRauius))),
          child: const Text(
            '북마크',
            style: TextStyle(
              color: Color(0xFF222222),
              fontSize: 12,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w400,
              // height: 18,
              letterSpacing: -0.24,
            ),
          ),
        ));
  }
}
