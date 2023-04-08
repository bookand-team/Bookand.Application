// import 'package:bookand/presentation/provider/geolocator_permission_provider.dart';
// import 'package:bookand/presentation/provider/map/widget_marker_provider.dart';
import 'dart:async';

import 'package:bookand/core/util/logger.dart';
import 'package:bookand/presentation/provider/map/geolocator_permission_provider.dart';
import 'package:bookand/presentation/provider/map/widget_marker_provider.dart';
import 'package:bookand/presentation/screen_logic/map/gps_permission_logic.dart';
import 'package:bookand/presentation/screen_logic/map/gps_position_logic.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

//providers
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bookand/presentation/provider/map/map_bools_providers.dart';
import 'package:bookand/presentation/provider/map/geolocator_position_provider.dart';
import 'package:bookand/presentation/provider/map/map_controller_provider.dart';
// import 'package:bookand/presentation/provider/map/map_marker_provider.dart';

class GpsButton extends ConsumerWidget {
  GpsButton({super.key});
  final double size = 32;
  Stream<LatLng>? geoStream;
  StreamSubscription<LatLng>? geoSub;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(gpsToggleProvider);
    final con = ref.read(gpsToggleProvider.notifier);
    //permission은 굳이 rebuild 필요 없음
    final gpsPermission = ref.read(geolocaotorPermissionNotifierProvider);
    final gpsPermissionCon =
        ref.read(geolocaotorPermissionNotifierProvider.notifier);

    final geoLocatorCon = ref.read(gelolocatorPostionNotifierProvider.notifier);
    final mapControllerCon = ref.read(mapControllerNotiferProvider.notifier);
//
    final markerCon = ref.read(widgetMarkerNotiferProvider.notifier);

    final testObjList = [
      TestObj(name: 'test1', type: 0, lat: 37.5665, lng: 126.9780),
      TestObj(name: 'test2', type: 1, lat: 37.5765, lng: 126.9780),
      TestObj(name: 'test3', type: 2, lat: 37.5865, lng: 126.9780),
      TestObj(name: 'test4', type: 3, lat: 37.5965, lng: 126.9780),
    ];

    void setListener() async {
      geoStream ??= geoLocatorCon.getStream();
      geoSub ??= geoStream?.listen(
        (event) {
          print('geo listen test = ' + event.toString());
          mapControllerCon.moveCamera(lat: event.lat, lng: event.lng);
        },
        onDone: () {
          print('해제됩니다');
        },
      );
      print('geosub =' + geoSub.toString());
    }

    void delListener() {
      // geoSub?.pause();
      print('geosub =' + geoSub.toString());
      if (geoSub != null) {
        if (!geoSub!.isPaused) {
          print('비활성화');
          geoSub?.pause();
        }
      }
    }

    return GestureDetector(
      onTap: () async {
        con.toggle();
        //활성화 시
        if (!selected) {
          markerCon.setTestMakrers(testObjList);
          if (gpsPermission != GpsPermission.enalbe) {
            gpsPermissionCon.getPermission().then((permission) {
              if (permission == GpsPermission.enalbe) {
                setListener();
              } else {
                logger.e("permission denied$permission");
              }
            });
          } else {
            setListener();
          }
          // 현재 화면에 출력된 마커들 print
          Future.delayed(
              Duration(milliseconds: 200),
              () async => print(markerCon.getMarkersInScreen(
                  await mapControllerCon.getScreenLatLngBounds())));
        } else {
          markerCon.initMarkers();
          delListener();
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
