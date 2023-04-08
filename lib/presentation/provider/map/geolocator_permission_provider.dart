import 'package:bookand/core/util/logger.dart';
import 'package:bookand/presentation/screen_logic/map/gps_permission_logic.dart';
import 'package:geolocator/geolocator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'geolocator_permission_provider.g.dart';

/// gelocator의 permission 상태, GelolocatorPostionNotifier에서 조정
@Riverpod(keepAlive: true)
class GeolocaotorPermissionNotifier extends _$GeolocaotorPermissionNotifier
    implements GpsPermissionLogic {
  @override
  GpsPermission build() {
    return GpsPermission.unknown;
  }

  GpsPermission transfer(LocationPermission permission) {
    GpsPermission out;
    switch (permission) {
      case LocationPermission.denied:
        out = GpsPermission.denied;
        break;
      case LocationPermission.deniedForever:
        out = GpsPermission.deniedForever;
        break;
      case LocationPermission.whileInUse:
        out = GpsPermission.enalbe;
        break;
      case LocationPermission.always:
        out = GpsPermission.enalbe;
        break;
      case LocationPermission.unableToDetermine:
        out = GpsPermission.deviceDisable;
        break;
    }
    return out;
  }

  @override
  Future<GpsPermission> getPermission() async {
    LocationPermission permission;
    bool serviceEnabled;
    // 기기의 gps 기능 체크
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      state = GpsPermission.deviceDisable;

      logger.e('gps가 없는 기기.');
      return state;
    }

    //기기에 대한 gps 권한 체크
    permission = await Geolocator.checkPermission();

    // permission denied 상태
    if (permission == LocationPermission.denied) {
      //기기에 대한 gps 권한 요청
      permission = await Geolocator.requestPermission();
      //기기에 대한 gps 권한 요청 -> 거부, 단순 거부이면 다시 요청하게 init 수정 x
      if (permission == LocationPermission.denied) {
        state = GpsPermission.denied;
      }
    }
    //기기에 대한 gps 권한 요청 -> 절대거부 -> 기기에선 다시 접근 불가, 유저가 직접 조정해야함
    else if (permission == LocationPermission.deniedForever) {
      state = GpsPermission.deniedForever;
    } else if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      state = GpsPermission.enalbe;
    } else {
      logger.d('알 수 없는 상태 =$permission');
    }
    return state;
  }
}
