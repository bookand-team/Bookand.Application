// import 'package:bookand/presentation/provider/geolocator_permission_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

//providers
import 'package:bookand/presentation/provider/map/geolocator_position_provider.dart';
import 'package:bookand/presentation/provider/map/map_state_proivders.dart';
import 'package:bookand/presentation/provider/map/map_controller_provider.dart';
import 'package:bookand/presentation/provider/map/map_marker_provider.dart';

class GpsButton extends ConsumerWidget {
  const GpsButton({super.key});
  final double size = 32;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(gpsToggleProvider);
    final con = ref.read(gpsToggleProvider.notifier);
    final geoLocatorCon = ref.read(gelolocatorPostionNotifierProvider.notifier);
    final markerCon = ref.read(mapMarkerNotiferProvider.notifier);
    final mapControllerCon = ref.read(mapControllerNotiferProvider.notifier);

    return GestureDetector(
      onTap: () async {
        con.toggle();
        markerCon.toggleUserMarker();
        //활성화 시
        if (!selected) {
          Position position = await geoLocatorCon.getPosition();
          markerCon.updateUserMarkerPos(
              lat: position.latitude, lng: position.longitude);
          mapControllerCon.moveCamera(
              lat: position.latitude, lng: position.longitude);
        }
      },
      child: Container(
        height: size,
        width: size,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(1000))),
        child: Icon(
          Icons.gps_not_fixed,
          color: selected ? Colors.amber : Colors.black,
        ),
      ),
    );
  }
}
