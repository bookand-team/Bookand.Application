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

// search page에서 돌아올 때 map tab에 있는 google map과 위치 동기화
  void syncPosition() {
    state.controller.moveCamera(CameraUpdate.newLatLng(state.latLng));
  }
}

class MyMap {
  late GoogleMapController controller;
  late GoogleMap googleMap;
  late LatLng latLng;
  bool inited = false;
  MyMap({required CameraPosition cameraPosition}) {
    latLng = cameraPosition.target;
    googleMap = GoogleMap(
      initialCameraPosition: cameraPosition,
      onMapCreated: (newController) {
        controller = newController;
      },
      onCameraMove: (position) {
        latLng = position.target;
      },
    );
    inited = true;
  }
}
