import 'package:geolocator/geolocator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'geolocator_permission_provider.g.dart';

/// gelocator의 permission 상태, GelolocatorPostionNotifier에서 조정
@Riverpod()
class GeolocaotorPermissionNotifier extends _$GeolocaotorPermissionNotifier {
  @override
  LocationPermission build() => LocationPermission.denied;

  void updatePermission(LocationPermission permission) {
    state = permission;
  }
}
