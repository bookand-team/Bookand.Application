import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:bookand/core/const/asset_path.dart';

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

@Riverpod()
class WidgetMarkerNotifer extends _$WidgetMarkerNotifer {
  @override
  Set<Marker> build() {
    basicIcon = Image.asset(mapBasicMarkerPath);
    bookmarkIcon = Image.asset(bookmarkActivatePath);
    hideIcon = Image.asset(mapHideMarkerPath);
    return {};
  }

  late Image basicIcon;
  late Image bookmarkIcon;
  late Image hideIcon;

  void setMarkers(Set<Marker> widgetMarkers) {
    state = widgetMarkers;
  }

  void setTestMakrers(List<TestObj> objs) async {
    Set<Marker> markers = {};

    for (var element in objs) {
      Image icon;

      //basick
      if (element.type == 0) {
        icon = basicIcon;
      }
      //bookmark
      else if (element.type == 1) {
        icon = bookmarkIcon;
      }
      // hide
      else if (element.type == 2) {
        icon = hideIcon;
      } else {
        icon = basicIcon;
      }

      Marker marker = Marker(
          markerId: MarkerId(element.name),
          position: LatLng(element.lat, element.lng),
          icon: await icon.toBitmapDescriptor());
      markers.add(marker);
    }
    state = markers;
  }

  void initMarkers() {
    state = {};
  }

  Set<Marker> getMarkersInScreen(LatLngBounds? bounds) {
    return bounds == null
        ? {}
        : state.where((element) => bounds.contains(element.position)).toSet();
  }

  // meter로 point와 marker 간의 거리 계산
  Future<double> getDistanceOfMarker(LatLng pointPos, LatLng markerPos) async {
    return await Geolocator.distanceBetween(pointPos.latitude,
        pointPos.longitude, markerPos.latitude, markerPos.longitude);
  }
}
