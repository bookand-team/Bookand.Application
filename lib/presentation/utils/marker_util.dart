import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:widget_to_marker/widget_to_marker.dart';

import '../component/custom_marker_icon.dart';

Future<Marker> createMarker({
  required String id,
  required String label,
  required double latitude,
  required double longitude,
  bool draggable = false,
  double? markerIconWidth,
  double? markerIconHeight,
  Function()? onTap,
}) async {
  return Marker(
    markerId: MarkerId(id),
    draggable: draggable,
    icon: await CustomMarkerIcon(
      label: label,
      width: markerIconWidth,
      height: markerIconHeight,
    ).toBitmapDescriptor(),
    position: LatLng(
      latitude,
      longitude,
    ),
    onTap: onTap,
  );
}
