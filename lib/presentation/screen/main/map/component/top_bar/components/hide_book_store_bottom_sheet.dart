import 'package:bookand/core/const/map.dart';
import 'package:bookand/core/widget/slide_icon.dart';
import 'package:bookand/domain/model/bookstore/bookstore_map_model.dart';
import 'package:bookand/presentation/provider/map/bottomhseet/map_button_height_provider.dart';
import 'package:bookand/presentation/provider/map/map_bookstores_provider.dart';
import 'package:bookand/presentation/provider/map/map_controller_provider.dart';
import 'package:bookand/presentation/provider/map/widget_marker_provider.dart';
import 'package:bookand/presentation/screen/main/map/component/book_store_tile.dart';
import 'package:bookand/presentation/screen/main/map/component/refresh_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HideBookStoreBottomSheet extends ConsumerStatefulWidget {
  const HideBookStoreBottomSheet({Key? key}) : super(key: key);

  @override
  ConsumerState<HideBookStoreBottomSheet> createState() =>
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
    getNewStore();

    super.initState();
  }

  void getNewStore() async {
    model = ref.read(mapBookStoreNotifierProvider.notifier).getRandomStore();
    if (model != null) {
      //화면 이동 조정
      await ref.read(mapControllerNotiferProvider.notifier).moveCamera(
          lat: (model!.latitude ?? SEOUL_COORD_LAT) - LAT_FIXED,
          lng: model!.longitude ?? SEOUL_COORD_LON);
      ref.read(widgetMarkerNotiferProvider.notifier).setOneHideMarker(model!);
    }
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
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('당신을 위한 보석같은 서점 추천', style: hideTitle),
              RefreshButton(
                onTap: () {
                  setState(() {
                    getNewStore();
                  });
                },
              )
            ],
          ),
          model == null
              ? const SizedBox()
              : BookStoreTile(
                  store: model!,
                )
        ],
      ),
    );
  }
}
