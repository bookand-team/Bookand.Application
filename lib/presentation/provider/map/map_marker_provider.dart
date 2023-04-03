import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'map_marker_provider.g.dart';

@Riverpod()
class MapMarkerNotifer extends _$MapMarkerNotifer {
  @override
  Set<Marker> build() => {};
  //초기 위치
  static const initPosition = LatLng(37.5665, 126.9780);
  //marker
  static String userMarkerId = 'user';
  Marker userMarker =
      Marker(markerId: MarkerId(userMarkerId), position: initPosition);

  void toggleUserMarker() {
    if (state.contains(userMarker)) {
      state = Set.from(state..remove(userMarker));
    } else {
      state = Set.from(state..add(userMarker));
    }
  }

  void updateUserMarkerPos({required double lat, required double lng}) {
    if (state.contains(userMarker)) {
      state = Set.from(state.map((e) {
        if (e.markerId.value == userMarkerId) {
          return e.copyWith(positionParam: LatLng(lat, lng));
        }
        return e;
      }));
    }
  }
}
