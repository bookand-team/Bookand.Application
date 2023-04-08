import 'package:bookand/core/util/logger.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'map_controller_provider.g.dart';

@Riverpod(keepAlive: true)
class MapControllerNotifer extends _$MapControllerNotifer {
  @override
  GoogleMapController? build() => null;
  //초기 위치
  static const initPosition = LatLng(37.5665, 126.9780);

  void initController(GoogleMapController controller) {
    state = controller;
  }

  void moveCamera({required double lat, required lng}) {
    state?.moveCamera(CameraUpdate.newLatLng(LatLng(lat, lng)));
  }

  Future<LatLngBounds?> getScreenLatLngBounds() async {
    return state?.getVisibleRegion();
  }
}
