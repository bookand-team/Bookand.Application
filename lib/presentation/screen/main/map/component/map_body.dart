// ignore_for_file: use_build_context_synchronously

import 'package:bookand/core/const/map.dart';
import 'package:bookand/presentation/component/bookmark_dialog.dart';
import 'package:bookand/presentation/provider/map/bools/map_hidestore_toggle.dart';
import 'package:bookand/presentation/provider/map/bools/map_search_bar_toggle.dart';
import 'package:bookand/presentation/provider/map/bottomhseet/map_bottomsheet_controller_provider.dart';
import 'package:bookand/presentation/provider/map/bottomhseet/map_button_height_provider.dart';
import 'package:bookand/presentation/provider/map/geolocator_permission_provider.dart';
import 'package:bookand/presentation/provider/map/geolocator_position_provider.dart';
import 'package:bookand/presentation/provider/map/map_body_key_provider.dart';
import 'package:bookand/presentation/provider/map/map_bookstores_provider.dart';
import 'package:bookand/presentation/provider/map/map_controller_provider.dart';
import 'package:bookand/presentation/provider/map/widget_marker_provider.dart';
import 'package:bookand/presentation/screen/main/map/component/gps_button.dart';
import 'package:bookand/presentation/screen/main/map/component/list_button.dart';
import 'package:bookand/presentation/screen/main/map/component/map_function_buttons.dart';
import 'package:bookand/presentation/screen/main/map/component/map_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
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
    double buttonHeight = ref.watch(mapButtonHeightNotifierProvider);
    Set<Marker> markers = ref.watch(widgetMarkerNotiferProvider);
    return Scaffold(
      key: ref.read(mapBodyKeyProvider),
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
              bottom: buttonHeight + buttonSpace + buttonPading,
              child: ListButton(
                onAcitve: () async {
                  final bounds = await ref
                      .read(mapControllerNotiferProvider.notifier)
                      .getScreenLatLngBounds();
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
          Positioned(
              right: buttonPading,
              bottom: buttonHeight + buttonPading,
              child: GpsButton(
                onAcitve: () async {
                  bool isGranted = await ref
                      .read(geolocaotorPermissionNotifierProvider.notifier)
                      .getPermission();
                  if (isGranted) {
                    ref
                        .read(gelolocatorPostionNotifierProvider.notifier)
                        .addGpsStreamListener((pos) {
                      ref
                          .read(mapControllerNotiferProvider.notifier)
                          .moveCamera(lat: pos.latitude, lng: pos.longitude);
                    });
                  } else {
                    showDialog(
                        context: context,
                        builder: (context) => BookmarkDialog(
                              title: 'Gsp 권한 설정',
                              description: '해당 기능을 사용하기 위해선 Gps 권한 설정이 필요합니다.',
                              leftButtonString: '취소',
                              rightButtonString: '설정',
                              onLeftButtonTap: () {},
                              onRightButtonTap: () {
                                Geolocator.openAppSettings();
                              },
                            ));
                  }
                },
                onDeactive: () {
                  ref
                      .read(gelolocatorPostionNotifierProvider.notifier)
                      .cancelGpsStreamListner();
                },
              )),
          Positioned(
            right: buttonPading,
            bottom: buttonHeight + buttonPading + 2 * buttonSpace,
            child: MapZoomOutButton(
              controller: ref.read(mapControllerNotiferProvider),
            ),
          ),
          Positioned(
            right: buttonPading,
            bottom: buttonHeight + buttonPading + 3 * buttonSpace,
            child: MapZoomInButton(
                controller: ref.read(mapControllerNotiferProvider)),
          )
        ],
      ),
    );
  }
}
