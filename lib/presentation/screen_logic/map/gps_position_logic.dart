class LatLng {
  double lat;
  double lng;
  LatLng({required this.lat, required this.lng});

  LatLng copyWith({double? lat, double? lng}) {
    return LatLng(lat: lat ?? this.lat, lng: lng ?? this.lng);
  }
}

// lat lng으로
abstract class GpsPositionLogic {
  Future getCurrentPosition();

  Stream<LatLng> getStream();
}
