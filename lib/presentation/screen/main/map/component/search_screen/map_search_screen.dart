// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:bookand/core/const/map.dart';
import 'package:bookand/core/widget/base_layout.dart';
import 'package:bookand/domain/model/bookstore/bookstore_map_model.dart';
import 'package:bookand/presentation/component/bookmark_dialog.dart';
import 'package:bookand/presentation/provider/map/bottomhseet/map_bottomsheet_controller_provider.dart';
import 'package:bookand/presentation/provider/map/bottomhseet/map_button_height_provider.dart';
import 'package:bookand/presentation/provider/map/geolocator_permission_provider.dart';
import 'package:bookand/presentation/provider/map/geolocator_position_provider.dart';
import 'package:bookand/presentation/provider/map/map_bookstores_provider.dart';
import 'package:bookand/presentation/provider/map/widget_marker_provider.dart';
import 'package:bookand/presentation/screen/main/map/component/gps_button.dart';
import 'package:bookand/presentation/screen/main/map/component/list_button.dart';
import 'package:bookand/presentation/screen/main/map/component/map_function_buttons.dart';
import 'package:bookand/presentation/screen/main/map/component/map_utils.dart';
import 'package:bookand/presentation/screen/main/map/component/search_screen/components/search_top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//providers
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

//components
import 'components/book_store_searched_tile.dart';
import 'components/no_search_text.dart';
import 'components/recommendation_button.dart';

class MapSearchScreen extends ConsumerStatefulWidget {
  static String get routeName => 'mapSearch';
  const MapSearchScreen({Key? key}) : super(key: key);

  @override
  _MapSearchScreenState createState() => _MapSearchScreenState();
}

class _MapSearchScreenState extends ConsumerState<MapSearchScreen> {
  FocusNode focusNode = FocusNode();

  List<BookStoreMapModel> searchedList = [];
  List<BookStoreMapModel> searchingList = [];

  bool isSearching = true;

  final TextEditingController searchTextCon = TextEditingController();

  double searchInterval = 0;
  final double constInterval = 0.5;

  final double slideBraidus = 24;
  // init camera
  CameraPosition initCamera =
      const CameraPosition(target: LatLng(37.5665, 126.9780), zoom: 13);

  final double buttonPading = 15;
  final double buttonSpace = 40;

  Set<Marker> markerSet = {};

  GoogleMapController? mapController;

  Widget createSearchBody() {
    //검색 끝나면 검색 화면 제거
    if (!isSearching) {
      return const SizedBox();
    } else {
      return Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children:
                    (searchTextCon.text.isNotEmpty && searchingList.isEmpty)
                        ? [
                            const Spacer(),
                            const NoSearchText(),
                            const Spacer(),
                            RecommendationButton(
                              onTap: () {
                                ref.context.pop('showhide');
                              },
                            ),
                            const SizedBox(
                              height: 40,
                            )
                          ]
                        : [
                            Expanded(
                                child: SingleChildScrollView(
                              child: Column(
                                children: searchingList
                                    .map((e) => BookStoreSearchedTile(
                                          model: e,
                                        ))
                                    .toList(),
                              ),
                            )),
                          ],
              ),
            )
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double buttonHeight = ref.watch(mapButtonHeightNotifierProvider);

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.black,
        statusBarIconBrightness: Brightness.dark));

    return SafeArea(
      child: BaseLayout(
          backgroundColor: Colors.white,
          onWillPop: () async {
            ref.context.pop();
            return true;
          },
          child: Scaffold(
              body: Builder(
            builder: (context) => Stack(
              children: [
                GoogleMap(
                    onTap: (argument) {
                      ref
                          .read(widgetMarkerNotiferProvider.notifier)
                          .setAllNormal();
                    },
                    zoomControlsEnabled: false,
                    onMapCreated: (controller) {
                      mapController = controller;
                    },
                    markers: markerSet,
                    initialCameraPosition: initCamera),
                Positioned(
                    right: buttonPading,
                    bottom: buttonHeight + buttonSpace + buttonPading,
                    child: ListButton(
                      onAcitve: () async {
                        final bounds = await mapController?.getVisibleRegion();
                        if (bounds == null) {
                          return;
                        }

                        final inScreen = await MapUtils.getBookstoresInScreen(
                            searchedList, bounds);
                        log('test in = $inScreen');
                        ref
                            .read(mapBottomSheetControllerProvider.notifier)
                            .showSearchPageSheet(
                                context: context, bookstoreList: inScreen);
                      },
                      onDeactive: () {
                        ref
                            .read(mapBottomSheetControllerProvider.notifier)
                            .close();
                      },
                    )),
                Positioned(
                    right: buttonPading,
                    bottom: buttonHeight + buttonPading,
                    child: GpsButton(
                      onAcitve: () async {
                        bool isGranted = await ref
                            .read(
                                geolocaotorPermissionNotifierProvider.notifier)
                            .getPermission();
                        if (isGranted) {
                          ref
                              .read(gelolocatorPostionNotifierProvider.notifier)
                              .addGpsStreamListener((pos) {
                            mapController?.moveCamera(CameraUpdate.newLatLng(
                                LatLng(pos.latitude, pos.longitude)));
                          });
                        } else {
                          showDialog(
                              context: context,
                              builder: (context) => BookmarkDialog(
                                    title: 'Gsp 권한 설정',
                                    description:
                                        '해당 기능을 사용하기 위해선 Gps 권한 설정이 필요합니다.',
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
                    controller: mapController,
                  ),
                ),
                Positioned(
                  right: buttonPading,
                  bottom: buttonHeight + buttonPading + 3 * buttonSpace,
                  child: MapZoomInButton(controller: mapController),
                ),
                createSearchBody(),
                Align(
                  alignment: Alignment.topCenter,
                  child: SearchTopBar(
                    onFieldFocus: () {
                      setState(() {
                        isSearching = true;
                      });
                    },
                    focusNode: focusNode,
                    controller: searchTextCon,

                    onChanged: (value) async {
                      setState(() {
                        searchingList = searchStores(value);
                      });
                    },
                    // 검색 완료 시
                    onSubmitted: (value) {
                      setState(() {
                        //검색
                        searchedList = searchStores(value);
                        if (searchedList.isEmpty) {
                          return;
                        }
                        isSearching = false;
                        //마커 출력
                        markerSet = ref
                            .read(widgetMarkerNotiferProvider.notifier)
                            .getSearchedMarker(searchedList);
                        //검색된 것 중 가장 가까운 서점으로 카메라 이동
                        if (mapController != null) {
                          mapController!.animateCamera(CameraUpdate.newLatLng(
                              LatLng(
                                  searchedList.first.latitude ??
                                      SEOUL_COORD_LAT,
                                  searchedList.first.longitude ??
                                      SEOUL_COORD_LON)));
                        }
                      });
                    },
                  ),
                )
              ],
            ),
          ))),
    );
  }

  List<BookStoreMapModel> searchStores(String data) {
    List<BookStoreMapModel> all = ref.read(mapBookStoreNotifierProvider);
    //검색어 포함한 store 거리 순으로 정렬해서 리턴
    List<BookStoreMapModel> searched =
        all.where((element) => element.name!.contains(data)).toList();
    searched.sort((a, b) => a.userDistance!.compareTo(b.userDistance!));
    return searched;
  }
}
