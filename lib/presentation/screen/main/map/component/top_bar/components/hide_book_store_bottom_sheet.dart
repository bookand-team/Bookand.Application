import 'package:bookand/core/widget/slide_icon.dart';
import 'package:bookand/domain/model/bookstore/bookstore_map_model.dart';
import 'package:bookand/presentation/provider/map/map_button_height_provider.dart';
import 'package:bookand/presentation/provider/map/map_filtered_book_store_provider.dart';
import 'package:bookand/presentation/screen/main/map/component/book_store_tile.dart';
import 'package:bookand/presentation/screen/main/map/component/refresh_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HideBookStoreBottomSheet extends ConsumerStatefulWidget {
  const HideBookStoreBottomSheet({Key? key}) : super(key: key);

  @override
  _HideBookStoreBottomSheetState createState() =>
      _HideBookStoreBottomSheetState();
}

class _HideBookStoreBottomSheetState
    extends ConsumerState<HideBookStoreBottomSheet> {
  final bottomSheetPadding =
      const EdgeInsets.symmetric(horizontal: 15, vertical: 5);
  final bottomSheetBr = const Radius.circular(24);
  final double bottomSheetHeight = MapButtonHeightNotifier.hideSheetHeight;
  final TextStyle hideTitle = const TextStyle(
      fontSize: 18, fontWeight: FontWeight.w700, color: Color(0xff222222));

  BookStoreMapModel? model;
  @override
  void initState() {
    model = ref
        .read(mapFilteredBooksStoreNotifierProvider.notifier)
        .getRandomStore();
    super.initState();
  }

  void getNewStore() {
    setState(() {
      model = ref
          .read(mapFilteredBooksStoreNotifierProvider.notifier)
          .getRandomStore();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: bottomSheetBr, topRight: bottomSheetBr)),
      padding: bottomSheetPadding,
      height: bottomSheetHeight,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          slideIcon,
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('당신을 위한 보석같은 서점 추천', style: hideTitle),
              RefreshButton(
                onTap: () {
                  getNewStore();
                },
              )
            ],
          ),
          model == null
              ? SizedBox()
              : BookStoreTile(
                  store: model!,
                )
        ],
      ),
    );
  }
}
