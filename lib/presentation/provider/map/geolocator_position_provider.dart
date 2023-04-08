import 'package:bookand/core/util/logger.dart';
import 'package:geolocator/geolocator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../screen_logic/map/gps_position_logic.dart';

part 'geolocator_position_provider.g.dart';

@Riverpod()
class GelolocatorPostionNotifier extends _$GelolocatorPostionNotifier
    implements GpsPositionLogic {
  static const seoulCoordi = [37.5642135, 127.0016985];
  @override
  LatLng build() {
    return LatLng(lat: seoulCoordi[0], lng: seoulCoordi[1]);
  }

  @override
  Future getCurrentPosition() async {
    Position position = await Geolocator.getCurrentPosition();
    state = LatLng(lat: position.latitude, lng: position.longitude);
    logger.d('사용자 위치 정보 얻기 성공$state');
  }

  @override
  Stream<LatLng> getStream() {
    return Geolocator.getPositionStream().map(
        (postion) => LatLng(lat: postion.latitude, lng: postion.longitude));
  }
}
