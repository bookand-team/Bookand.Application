import 'package:bookand/core/const/map.dart';
import 'package:bookand/core/util/logger.dart';
import 'package:geolocator/geolocator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../screen_logic/map/gps_position_logic.dart';

part 'geolocator_position_provider.g.dart';

@Riverpod(keepAlive: true)
class GelolocatorPostionNotifier extends _$GelolocatorPostionNotifier
    implements GpsPositionLogic {
  static const seoulCoordi = [37.5642135, 127.0016985];

  bool inited = false;

  @override
  LatLng build() {
    return LatLng(lat: seoulCoordi[0], lng: seoulCoordi[1]);
  }

  @override
  Future<LatLng> getCurrentPosition() async {
    if (inited) {
      return state;
    }
    Position? position;
    LatLng coord = LatLng(lat: SEOUL_COORD[0], lng: SEOUL_COORD[1]);
    try {
      position = await Geolocator.getCurrentPosition();
    } catch (e) {
      logger.e(
          'GelolocatorPostionNotifier, geolocator get current position error');
    }
    if (position != null) {
      coord = LatLng(lat: position.latitude, lng: position.longitude);
    }
    state = coord;
    inited = true;
    return state;
  }

  @override
  Stream<LatLng> getStream() {
    return Geolocator.getPositionStream().map(
        (postion) => LatLng(lat: postion.latitude, lng: postion.longitude));
  }
}
