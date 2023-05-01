// import 'package:bookand/presentation/provider/geolocator_permission_provider.dart';
// import 'package:bookand/presentation/provider/map/widget_marker_provider.dart';
import 'dart:async';

import 'package:bookand/core/util/logger.dart';
import 'package:bookand/presentation/provider/map/geolocator_permission_provider.dart';
import 'package:bookand/presentation/provider/map/geolocator_position_provider.dart';
import 'package:bookand/presentation/provider/map/map_bools_providers.dart';
import 'package:bookand/presentation/provider/map/map_controller_provider.dart';
import 'package:bookand/presentation/screen_logic/map/gps_permission_logic.dart';
import 'package:bookand/presentation/screen_logic/map/gps_position_logic.dart';
import 'package:flutter/material.dart';
//providers
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:bookand/presentation/provider/map/map_marker_provider.dart';

class GpsButton extends ConsumerWidget {
  GpsButton({super.key});
  final double size = 32;
  StreamSubscription<LatLng>? geoSub;
  Stream<LatLng>? geoStream;
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

    void setListener() async {
      geoStream ??= geoLocatorCon.getStream();
      geoSub ??= geoStream?.listen(
        (event) {
          mapControllerCon.moveCamera(lat: event.lat, lng: event.lng);
        },
        onDone: () {},
      );
    }

    void delListener() {
      // geoSub?.pause();
      if (geoSub != null) {
        if (!geoSub!.isPaused) {
          geoSub?.pause();
        }
      }
    }

    return GestureDetector(
      onTap: () async {
        con.toggle();
        //활성화 시
        if (!selected) {
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
        } else {
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
