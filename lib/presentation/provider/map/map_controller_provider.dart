import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'map_controller_provider.g.dart';

@Riverpod()
class MapControllerNotifer extends _$MapControllerNotifer {
  @override
  GoogleMapController? build() => null;
  //초기 위치
  static const initPosition = LatLng(37.5665, 126.9780);

  bool inited = false;

  void initController(GoogleMapController controller) {
    state = controller;
    inited = true;
  }

  Future moveCamera({required double lat, required lng}) async {
    if (inited) {
      await state?.moveCamera(CameraUpdate.newLatLng(LatLng(lat, lng)));
    }
  }

  Future zoomIn() async {
    if (inited) {
      await state?.animateCamera(CameraUpdate.zoomIn());
    }
  }

  Future zoomOut() async {
    if (inited) {
      await state?.animateCamera(CameraUpdate.zoomOut());
    }
  }

  Future<LatLngBounds?> getScreenLatLngBounds() async {
    if (inited) {
      return state?.getVisibleRegion();
    } else {
      return null;
    }
  }
}
