import 'dart:async';

import 'package:bookand/core/const/map.dart';
import 'package:bookand/core/util/logger.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'geolocator_position_provider.g.dart';

@Riverpod(keepAlive: true)
class GelolocatorPostionNotifier extends _$GelolocatorPostionNotifier {
  static const seoulCoordi = [37.5642135, 127.0016985];

  bool inited = false;

  StreamSubscription<Position>? positionStream;

  @override
  LatLng build() {
    return LatLng(seoulCoordi[0], seoulCoordi[1]);
  }

  Future<LatLng> getCurrentPosition() async {
    if (inited) {
      return state;
    }
    Position? position;
    LatLng coord = LatLng(SEOUL_COORD[0], SEOUL_COORD[1]);
    try {
      position = await Geolocator.getCurrentPosition();
    } catch (e) {
      logger.e(
          'GelolocatorPostionNotifier, geolocator get current position error');
    }
    if (position != null) {
      coord = LatLng(position.latitude, position.longitude);
    }
    state = coord;
    inited = true;
    return state;
  }

  void addGpsStreamListener(void Function(Position pos) onPosition) {
    if (positionStream != null) {
      positionStream?.cancel();
      positionStream = null;
      addGpsStreamListener((pos) {
        onPosition(pos);
      });
    } else {
      positionStream =
          Geolocator.getPositionStream().listen((Position position) {
        state = LatLng(position.latitude, position.longitude);
        onPosition(position);
      });
    }
  }

  void cancelGpsStreamListner() {
    positionStream?.cancel();
    positionStream = null;
  }
}
