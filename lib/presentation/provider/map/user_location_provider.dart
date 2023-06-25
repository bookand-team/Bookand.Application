import 'dart:async';

import 'package:bookand/core/const/map.dart';
import 'package:bookand/core/util/logger.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_location_provider.g.dart';

/// 유저의 현재 위치 정보를 얻거나 리스너를 통해 계속 갱신된 값을 가지고 있을 프로바이더
@Riverpod(keepAlive: true)
class UserLocationProvider extends _$UserLocationProvider {
  @override
  LatLng build() => const LatLng(SEOUL_COORD_LAT, SEOUL_COORD_LON);
  bool isListening = false;

  StreamSubscription<Position>? locationSub;

  Future<LatLng> getCurrentPosition() async {
    try {
      final data = await Geolocator.getCurrentPosition();
      state = LatLng(data.latitude, data.longitude);
    } catch (e) {
      logger.e('getCurrentPosition, error = $e');
    }
    return state;
  }

  Future startTrackLocation() async {
    stopTrackLocation();
    try {
      locationSub = Geolocator.getPositionStream().listen(_onLocationChanged);
    } catch (e) {
      logger.e('startTrackLocation, error = $e');
    }
  }

  stopTrackLocation() {
    locationSub?.cancel();
    locationSub = null;
  }

  void _onLocationChanged(Position data) {
    state = LatLng(data.latitude, data.longitude);
  }

  // 위치를 받을 수 있는 권한, 서비스 체크
  Future<bool> checkPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return false;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return false;
    }
    return true;
  }

  Future<bool> checkPermissionAndListen() async {
    if (await checkPermission()) {
      await startTrackLocation();
      return true;
    } else {
      return false;
    }
  }
}
