import 'package:bookand/core/const/map.dart';
import 'package:bookand/domain/model/bookstore/bookstore_map_model.dart';
import 'package:bookand/gen/assets.gen.dart';
import 'package:bookand/presentation/provider/map/bottomhseet/map_bottomsheet_controller_provider.dart';
import 'package:bookand/presentation/provider/map/map_controller_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
// lib test
import 'package:widget_to_marker/widget_to_marker.dart';

part 'widget_marker_provider.g.dart';

/// widget으로 google map에 marker를 생성하기 위한 프로바이더, state를 watch하고, googlemap에 파라미터로 전달하는 방식으로 구현

@Riverpod(keepAlive: true)
class WidgetMarkerNotifer extends _$WidgetMarkerNotifer {
  @override
  Set<Marker> build() {
    return {};
  }

  Set<Marker> allMarker = {};
  String selectedId = 'selected';
  Marker? selectedMarker;
  Marker? hidestoreMarker;

  Widget bookmarkNormal = SvgPicture.asset(
    Assets.images.map.bookstoreNormal,
    width: 28,
    height: 28,
  );
  Widget bookmarkBig = SvgPicture.asset(
    Assets.images.map.bookstoreBig,
    width: 36,
    height: 36,
  );
  Widget hidestore = SvgPicture.asset(Assets.images.map.hidestore);
  Widget createMarkerText(String data, [bool big = false]) {
    Radius br = const Radius.circular(5);
    TextStyle style = TextStyle(color: Colors.black, fontSize: big ? 15 : 13);
    EdgeInsets padding = const EdgeInsets.symmetric(vertical: 3, horizontal: 5);
    Color color = Colors.white.withOpacity(0.5);
    return Container(
      padding: padding,
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.all(br)),
      child: Text(
        data,
        style: style,
      ),
    );
  }

  Widget createHidestoreBody(String data) {
    return SizedBox(
      height: 60,
      child: Column(
        children: [hidestore, createMarkerText(data)],
      ),
    );
  }

  Widget createBigBody(String data) {
    return SizedBox(
      height: 70,
      child: Column(
        children: [bookmarkBig, createMarkerText(data, true)],
      ),
    );
  }

  Widget createNormalBody(String data) {
    return SizedBox(
      height: 60,
      child: Column(
        children: [bookmarkNormal, createMarkerText(data)],
      ),
    );
  }

  void initMarkers(
      List<BookStoreMapModel> bookstoreList, BuildContext context) async {
    for (BookStoreMapModel store in bookstoreList) {
      Marker marker = Marker(
        onTap: () async {
          // 다른 마커 정상화
          setAllNormal();
          // 눌러진 마커 검색
          Iterable<Marker> iter =
              state.where((element) => element.markerId.value == store.name);
          if (iter.isNotEmpty) {
            // 눌러진 마커 확대로 변경
            selectedMarker = iter.first.copyWith(
                zIndexParam: 1,
                iconParam:
                    await createBigBody(store.name!).toBitmapDescriptor());

            // rebuild
            state = {...state};

            //bottomsheet update
            // ref
            //     .read(mapInScreenBookStoreNotifierProvider.notifier)
            //     .setOne(store);
            ref
                .read(mapBottomSheetControllerProvider.notifier)
                .showBookstoreSheet(context: context, bookstoreList: [store]);

            // 마커 누르면 마커가 바텀시트에 안가리게 위치 조정해서 이동
            ref.read(mapControllerNotiferProvider)?.animateCamera(
                CameraUpdate.newLatLng(LatLng(
                    selectedMarker!.position.latitude - 0.03,
                    selectedMarker!.position.longitude)));
          }
        },
        markerId: MarkerId(store.name!),
        position: LatLng(store.latitude ?? SEOUL_COORD_LAT,
            store.longitude ?? SEOUL_COORD_LON),
        icon: await createNormalBody(store.name!).toBitmapDescriptor(),
      );
      state = {...state, marker};
    }
    allMarker = state;
  }

  void setAllNormal() async {
    if (selectedMarker != null) {
      state.remove(selectedMarker);
    }
    if (hidestoreMarker != null) {
      state.remove(hidestoreMarker);
    }
    state = Set.from(state);
  }

  void setBookstoreMarker(List<BookStoreMapModel> bookstoreList) {
    List<String> listForShow = bookstoreList.map((e) => e.name!).toList();
    state = allMarker
        .where((element) => listForShow.contains(element.markerId.value))
        .toSet();
  }

  void setOneHideMarker(String name) async {
    setAllNormal();
    Iterable<Marker> iter =
        state.where((element) => element.markerId.value == name);
    if (iter.isNotEmpty) {
      hidestoreMarker = iter.first.copyWith(
          zIndexParam: 1,
          iconParam: await createHidestoreBody(name).toBitmapDescriptor());
      state.add(hidestoreMarker!);
      state = {...state};
    }
  }
}
