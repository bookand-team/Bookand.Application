// import 'package:bookand/presentation/provider/geolocator_permission_provider.dart';
// import 'package:bookand/presentation/provider/map/widget_marker_provider.dart';
import 'package:bookand/presentation/provider/map/widget_marker_provider.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

//providers
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bookand/presentation/provider/map/map_bools_providers.dart';
import 'package:bookand/presentation/provider/map/geolocator_position_provider.dart';
import 'package:bookand/presentation/provider/map/map_controller_provider.dart';
// import 'package:bookand/presentation/provider/map/map_marker_provider.dart';

class GpsButton extends ConsumerWidget {
  const GpsButton({super.key});
  final double size = 32;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(gpsToggleProvider);
    final con = ref.read(gpsToggleProvider.notifier);
    final geoLocatorCon = ref.read(gelolocatorPostionNotifierProvider.notifier);
    // final markerCon = ref.read(mapMarkerNotiferProvider.notifier);
    final mapControllerCon = ref.read(mapControllerNotiferProvider.notifier);

    //test2
    final markerCon = ref.read(widgetMarkerNotiferProvider.notifier);
    final testObjList = [
      TestObj(name: 'test1', type: 0, lat: 37.5665, lng: 126.9780),
      TestObj(name: 'test2', type: 1, lat: 37.5765, lng: 126.9780),
      TestObj(name: 'test3', type: 2, lat: 37.5865, lng: 126.9780),
      TestObj(name: 'test4', type: 3, lat: 37.5965, lng: 126.9780),
    ];
    return GestureDetector(
      onTap: () {
        con.toggle();
        // markerCon.toggleUserMarker();
        //활성화 시
        if (!selected) {
          // Position position = await geoLocatorCon.getPosition();
          // markerCon.updateUserMarkerPos(
          // lat: position.latitude, lng: position.longitude);
          // mapControllerCon.moveCamera(
          // lat: position.latitude, lng: position.longitude);
          // markerCon.setTestMakrers(testObjList);
          // try {
          //   Future.delayed(Duration(milliseconds: 100),
          //       () => widgetMarkerCon.setTestMakrers(testObjList));
          // } catch (e) {
          //   print(e);
          // }
          markerCon.setTestMakrers(testObjList);
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
