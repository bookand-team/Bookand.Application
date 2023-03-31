import 'package:bookand/core/util/logger.dart';
import 'package:bookand/presentation/provider/geolocator_permission_provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

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

  Future<Position> getPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      logger.e('Location services are disabled.');
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      permissionCon.updatePermission(permission);
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    permissionCon.updatePermission(permission);
    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }
}
