// ignore_for_file: use_build_context_synchronously

import 'package:bookand/core/const/map.dart';
import 'package:bookand/presentation/provider/map/bools/map_hidestore_toggle.dart';
import 'package:bookand/presentation/provider/map/bools/map_search_bar_toggle.dart';
import 'package:bookand/presentation/provider/map/bottomhseet/map_bottomsheet_controller_provider.dart';
import 'package:bookand/presentation/provider/map/bottomhseet/map_button_height_provider.dart';
import 'package:bookand/presentation/provider/map/bottomhseet/map_button_min_height_provider.dart';
import 'package:bookand/presentation/provider/map/map_controller_provider.dart';
import 'package:bookand/presentation/provider/map/map_in_screen_bookstores_provider.dart';
import 'package:bookand/presentation/provider/map/widget_marker_provider.dart';
import 'package:bookand/presentation/screen/main/map/component/gps_button.dart';
import 'package:bookand/presentation/screen/main/map/component/list_button.dart';
import 'package:bookand/presentation/screen/main/map/component/map_function_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapBody extends ConsumerStatefulWidget {
  const MapBody({Key? key}) : super(key: key);

  @override
  _MapTestState createState() => _MapTestState();
}

class _MapTestState extends ConsumerState<MapBody> {
  final double buttonPading = 15;
  //버튼 사이의 간격
  final double buttonSpace = 40;

  @override
  Widget build(BuildContext context) {
    // final buttonHeightCon = ref.read(mapButtonHeightNotifierProvider.notifier);
    double buttonHeight = ref.watch(mapButtonHeightNotifierProvider);
    double minHeight = ref.watch(mapButtonMinHeightNotifier);
    Set<Marker> markers = ref.watch(widgetMarkerNotiferProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          GoogleMap(
              mapToolbarEnabled: false,
              onTap: (argument) {
                ref.read(widgetMarkerNotiferProvider.notifier).setAllNormal();
              },
              zoomControlsEnabled: false,
              onMapCreated: (controller) {
                ref
                    .read(mapControllerNotiferProvider.notifier)
                    .initController(controller);
              },
              markers: markers,
              initialCameraPosition: const CameraPosition(
                  target: LatLng(SEOUL_COORD_LAT, SEOUL_COORD_LON), zoom: 13)),

          //떠있는 버튼들 시작
          Positioned(
              right: buttonPading,
              bottom: minHeight + buttonHeight + buttonSpace + buttonPading,
              child: ListButton(
                onAcitve: () async {
                  final inMap = await ref
                      .read(mapInScreenBookStoreNotifierProvider.notifier)
                      .fetchInScreenBookstore();

                  ref
                      .read(mapBottomSheetControllerProvider.notifier)
                      .showBookstoreSheet(
                        context: context,
                        bookstoreList: inMap,
                        onInnerScrollUp: () {
                          ref
                              .read(mapSearchBarToggleProvider.notifier)
                              .activate();
                        },
                        onInnerScrollDown: () {
                          ref
                              .read(mapSearchBarToggleProvider.notifier)
                              .deactivate();
                        },
                      );
                },
                onDeactive: () {
                  ref.read(mapBottomSheetControllerProvider)?.close();
                  ref.read(hideStoreToggleProvider.notifier).deactivate();
                },
              )),
          Positioned(
              right: buttonPading,
              bottom: minHeight + buttonHeight + buttonPading,
              child: GpsButton(
                onAcitve: () {},
                onDeactive: () {},
              )),
          Positioned(
            right: buttonPading,
            bottom: minHeight + buttonHeight + buttonPading + 2 * buttonSpace,
            child: const MapZoomOutButton(),
          ),
          Positioned(
            right: buttonPading,
            bottom: minHeight + buttonHeight + buttonPading + 3 * buttonSpace,
            child: const MapZoomInButton(),
          )
        ],
      ),
    );
  }
}
