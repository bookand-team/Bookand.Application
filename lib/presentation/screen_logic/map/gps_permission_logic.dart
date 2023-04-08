enum GpsPermission { enalbe, denied, deniedForever, deviceDisable, unknown }

///state는 enum gps permission
abstract class GpsPermissionLogic {
  Future<GpsPermission> getPermission();
}
