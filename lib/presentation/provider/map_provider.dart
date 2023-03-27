import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final myMapProvider =
    StateNotifierProvider<MyMapNotifier, MyMap>((ref) => MyMapNotifier());

class MyMapNotifier extends StateNotifier<MyMap> {
  MyMapNotifier()
      : super(MyMap(
            cameraPosition: const CameraPosition(
                target: initPosition, zoom: zoom))); // 초기 위치를 서울로 설정
  //초기 위치
  static const initPosition = LatLng(37.5665, 126.9780);
  static const double zoom = 13;

  void moveMap() {
    state.controller.moveCamera(CameraUpdate.newLatLng(initPosition));
  }
}

class MyMap {
  late GoogleMapController controller;
  // 검색 페이지에서 새로 생길 구글 맵에 할당하는 컨트롤러
  late GoogleMapController secondMapController;
  late GoogleMap googleMap;
  late LatLng latLng;
  bool mainMapinited = false;
  MyMap({required CameraPosition cameraPosition}) {
    latLng = cameraPosition.target;
    googleMap = GoogleMap(
      zoomControlsEnabled: false,
      initialCameraPosition: cameraPosition,
      onMapCreated: (newController) {
        if (mainMapinited) {
          secondMapController = newController;
        } else {
          controller = newController;
        }
        mainMapinited = true;
      },
      onCameraMove: (position) {
        latLng = position.target;
      },
    );
  }
}
