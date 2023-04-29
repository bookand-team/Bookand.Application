import 'dart:developer';

import 'package:bookand/domain/model/bookstore/bookstore_map_model.dart';
import 'package:bookand/gen/assets.gen.dart';
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

  late Image basicIcon;
  late Image bookmarkIcon;
  late Image hideIcon;
  Widget bookmarkNormal = SvgPicture.asset(Assets.images.map.bookstoreNormal);
  Widget createMarkerText(String data) {
    Radius br = const Radius.circular(5);
    TextStyle style = const TextStyle(color: Colors.black);
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

  void initMarkers(List<BookStoreMapModel> bookstoreList) async {
    for (BookStoreMapModel store in bookstoreList) {
      Set<Marker> markers = {};
      Widget body = SizedBox(
        height: 50,
        child: Column(
          children: [bookmarkNormal, createMarkerText(store.name!)],
        ),
      );
      Marker marker = Marker(
        markerId: MarkerId(store.id.toString()),
        position: LatLng(store.latitude!, store.longitude!),
        icon: await body.toBitmapDescriptor(),
      );
      markers.add(marker);
      state = Set.from(state..add(marker));
      log('marker added');
      allMarker = state;
    }
  }

  void setBookstoreMarker(List<BookStoreMapModel> bookstoreList) {
    List<String> listForShow =
        bookstoreList.map((e) => e.id.toString()).toList();
    state = allMarker
        .where((element) => listForShow.contains(element.markerId.value))
        .toSet();
  }
}
