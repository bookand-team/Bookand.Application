import 'dart:developer';

import 'package:bookand/core/const/map.dart';
import 'package:bookand/core/util/logger.dart';
import 'package:bookand/domain/model/bookstore/bookstore_map_model.dart';
import 'package:bookand/gen/assets.gen.dart';
import 'package:bookand/presentation/provider/map/map_in_screen_bookstores_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
// lib test
import 'package:widget_to_marker/widget_to_marker.dart';

part 'widget_marker_provider.g.dart';

class TestObj {
  String name;
  int type;
  double lat;
  double lng;
  TestObj(
      {required this.name,
      required this.type,
      required this.lat,
      required this.lng});
}

/// widget으로 google map에 marker를 생성하기 위한 프로바이더, state를 watch하고, googlemap에 파라미터로 전달하는 방식으로 구현
@Riverpod()
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

  void initMarkers(List<BookStoreMapModel> bookstoreList) async {
    for (BookStoreMapModel store in bookstoreList) {
      Set<Marker> markers = {};

      Marker marker = Marker(
        onTap: () async {
          setAllNormal();
          logger.d('tes');
          Iterable<Marker> iter =
              state.where((element) => element.markerId.value == store.name);
          if (iter.isNotEmpty) {
            selectedMarker = iter.first.copyWith(
                zIndexParam: 1,
                iconParam:
                    await createBigBody(store.name!).toBitmapDescriptor());

            state.add(selectedMarker!);
            state = Set.from(state);

            ref
                .read(mapInScreenBookStoreNotifierProvider.notifier)
                .setOne(store);
          }
        },
        markerId: MarkerId(store.name!),
        position: LatLng(store.latitude ?? SEOUL_COORD_LAT,
            store.longitude ?? SEOUL_COORD_LON),
        icon: await createNormalBody(store.name!).toBitmapDescriptor(),
      );
      markers.add(marker);
      state = Set.from(state..add(marker));
      log('marker added');
      allMarker = state;
    }
  }

  void setAllNormal() async {
    if (selectedMarker != null) {
      state.remove(selectedMarker);
    }
    if (hidestoreMarker != null) {
      state.remove(hidestoreMarker);
      // state = Set.from(state);
    }

    //   Iterable<Marker> iter = state.where((element) => element.zIndex == 1);
    //   if (iter.isNotEmpty) {
    //     iter.forEach((element) async {
    //       Marker marker = element;
    //       state.remove(marker);
    //       state.add(marker.copyWith(
    //           zIndexParam: 0,
    //           iconParam: await createNormalBody(marker.markerId.value)
    //               .toBitmapDescriptor()));
    //     });
    //   }
    //   state = Set.from(state);
  }

  void setBookstoreMarker(List<BookStoreMapModel> bookstoreList) {
    List<String> listForShow =
        bookstoreList.map((e) => e.id.toString()).toList();
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
      state = Set.from(state);
    }
  }
}
