import 'package:bookand/core/util/logger.dart';
import 'package:geolocator/geolocator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// devpendency
import 'package:bookand/presentation/provider/map/geolocator_permission_provider.dart';

part 'geolocator_position_provider.g.dart';

@Riverpod()
class GelolocatorPostionNotifier extends _$GelolocatorPostionNotifier {
  late GeolocaotorPermissionNotifier permissionCon;
  static const seoulCoordi = [37.5642135, 127.0016985];
  @override
  Position build() {
    permissionCon = ref.read(geolocaotorPermissionNotifierProvider.notifier);
    return Position(
        latitude: seoulCoordi.first,
        longitude: seoulCoordi.last,
        timestamp: DateTime(2023),
        accuracy: 0,
        altitude: 0,
        heading: 0,
        speed: 0,
        speedAccuracy: 0);
  }

  Future<dynamic> getPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // 기기의 gps 기능 체크
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      logger.e('Location services are disabled.');
      return Future.error('Location services are disabled.');
    }

    //기기에 대한 gps 권한 체크
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      //기기에 대한 gps 권한 요청
      permission = await Geolocator.requestPermission();
      //기기에 대한 gps 권한 요청 -> 거부
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    //기기에 대한 gps 권한 요청 -> 절대거부 -> 기기에선 다시 접근 불가, 유저가 직접 조정해야함
    if (permission == LocationPermission.deniedForever) {
      permissionCon.updatePermission(permission);
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    //기기에 대한 gps 권한 요청 -> LocationPermission.always  or LocationPermission.whileInUse
    permissionCon.updatePermission(permission);
    state = await Geolocator.getCurrentPosition();
    logger.d('사용자 위치 정보 얻기 성공' + state.toString());
    return state;
  }
}
