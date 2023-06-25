// ignore_for_file: use_build_context_synchronously

import 'package:bookand/core/const/map.dart';
import 'package:bookand/presentation/provider/map/bools/map_hidestore_toggle.dart';
import 'package:bookand/presentation/provider/map/bools/map_search_bar_toggle.dart';
import 'package:bookand/presentation/provider/map/bottomhseet/map_bottomsheet_controller_provider.dart';
import 'package:bookand/presentation/provider/map/bottomhseet/map_button_height_provider.dart';
import 'package:bookand/presentation/provider/map/map_body_key_provider.dart';
import 'package:bookand/presentation/provider/map/map_bookstores_provider.dart';
import 'package:bookand/presentation/provider/map/map_controller_provider.dart';
import 'package:bookand/presentation/provider/map/user_location_provider.dart';
import 'package:bookand/presentation/provider/map/widget_marker_provider.dart';
import 'package:bookand/presentation/screen/main/map/component/gps_button.dart';
import 'package:bookand/presentation/screen/main/map/component/list_button.dart';
import 'package:bookand/presentation/screen/main/map/component/map_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapBody extends ConsumerStatefulWidget {
  const MapBody({Key? key}) : super(key: key);

  @override
  ConsumerState<MapBody> createState() => _MapBodyState();
}

class _MapBodyState extends ConsumerState<MapBody> {
  final double buttonPading = 15;
  //버튼 사이의 간격
  final double buttonSpace = 40;

  bool showLocationPub = false;

  GoogleMapController? googleMapController;

  @override
  Widget build(BuildContext context) {
    double buttonHeight = ref.watch(mapButtonHeightNotifierProvider);
    Set<Marker> markers = ref.watch(widgetMarkerNotiferProvider);
    return Scaffold(
      key: ref.read(mapBodyKeyProvider),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          GoogleMap(
              myLocationEnabled: showLocationPub,
              myLocationButtonEnabled: false,
              mapToolbarEnabled: false,
              onTap: (argument) {
                ref.read(widgetMarkerNotiferProvider.notifier).setAllNormal();
              },
              zoomControlsEnabled: false,
              onMapCreated: (controller) {
                ref
                    .read(mapControllerNotiferProvider.notifier)
                    .initController(controller);
                googleMapController = controller;
              },
              markers: markers,
              initialCameraPosition: const CameraPosition(
                  target: LatLng(SEOUL_COORD_LAT, SEOUL_COORD_LON),
                  zoom: DEFAULT_ZOOM)),

          //떠있는 버튼들 시작
          Positioned(
              right: buttonPading,
              bottom: buttonHeight + buttonSpace + buttonPading,
              child: ListButton(
                onAcitve: () async {
                  final bounds = await googleMapController?.getVisibleRegion();
                  if (bounds == null) {
                    return;
                  }

                  final inScreen = await MapUtils.getBookstoresInScreen(
                      ref.read(mapBookStoreNotifierProvider), bounds);

                  ref
                      .read(mapBottomSheetControllerProvider.notifier)
                      .showBookstoreSheet(
                        bookstoreList: inScreen,
                        onInnerScrollUp: () {
                          ref
                              .read(mapSearchBarToggleNotifierProvider.notifier)
                              .activate();
                        },
                        onInnerScrollDown: () {
                          ref
                              .read(mapSearchBarToggleNotifierProvider.notifier)
                              .deactivate();
                        },
                      );
                },
                onDeactive: () {
                  ref.read(mapBottomSheetControllerProvider)?.close();
                  ref
                      .read(hideStoreToggleNotifierProvider.notifier)
                      .deactivate();
                },
              )),
          //GPS 버튼
          Positioned(
              right: buttonPading,
              bottom: buttonHeight + buttonPading,
              child: GpsButton(
                onAcitve: () async {
                  setState(() {
                    showLocationPub = true;
                  });
                  final pos = ref.read(userLocationProviderProvider);
                  googleMapController?.animateCamera(
                      CameraUpdate.newLatLngZoom(pos, DEFAULT_ZOOM));
                },
                onDeactive: () {
                  setState(() {
                    showLocationPub = false;
                  });
                },
              )),
          // TODO for dev
          // Positioned(
          //   right: buttonPading,
          //   bottom: buttonHeight + buttonPading + 2 * buttonSpace,
          //   child: MapZoomOutButton(
          //     controller: googleMapController,
          //   ),
          // ),
          // Positioned(
          //     right: buttonPading,
          //     bottom: buttonHeight + buttonPading + 3 * buttonSpace,
          //     child: MapZoomInButton(
          //       controller: googleMapController,
          //     ))
        ],
      ),
    );
  }
}
