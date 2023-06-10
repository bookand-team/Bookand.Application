import 'dart:developer';

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
    log('test state = $state');
  }

  void clear() {
    state = null;
  }

  Future moveCamera({required double lat, required lng}) async {
    await state?.moveCamera(CameraUpdate.newLatLng(LatLng(lat, lng)));
  }

  Future zoomIn() async {
    log('tes');
    await state?.animateCamera(CameraUpdate.zoomIn());
  }

  Future zoomOut() async {
    await state?.animateCamera(CameraUpdate.zoomOut());
  }

  Future<LatLngBounds?> getScreenLatLngBounds() async {
    return state?.getVisibleRegion();
  }
}
