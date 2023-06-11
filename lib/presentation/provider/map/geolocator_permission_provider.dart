import 'package:bookand/core/util/logger.dart';
import 'package:geolocator/geolocator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'geolocator_permission_provider.g.dart';

/// gelocator의 permission 상태, GelolocatorPostionNotifier에서 조정
@Riverpod(keepAlive: true)
class GeolocaotorPermissionNotifier extends _$GeolocaotorPermissionNotifier {
  @override
  bool build() {
    return false;
  }

  Future<bool> getPermission() async {
    LocationPermission permission;
    bool serviceEnabled;
    // 기기의 gps 기능 체크
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      logger.e('gps가 없는 기기.');
      state = false;
      return false;
    }

    //기기에 대한 gps 권한 체크
    permission = await Geolocator.requestPermission();

    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      state = true;
      return true;
    } else {
      state = false;
      return false;
    }
  }
}
