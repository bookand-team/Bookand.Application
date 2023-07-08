// ignore_for_file: use_build_context_synchronously

import 'package:bookand/core/const/map.dart';
import 'package:bookand/core/widget/base_layout.dart';
import 'package:bookand/domain/model/bookstore/bookstore_map_model.dart';
import 'package:bookand/presentation/provider/map/bottomhseet/map_bottomsheet_controller_provider.dart';
import 'package:bookand/presentation/provider/map/bottomhseet/map_button_height_provider.dart';
import 'package:bookand/presentation/provider/map/bottomhseet/map_list_toggle.dart';
import 'package:bookand/presentation/provider/map/map_bookstores_provider.dart';
import 'package:bookand/presentation/provider/map/widget_marker_provider.dart';
import 'package:bookand/presentation/screen/main/map/component/gps_button.dart';
import 'package:bookand/presentation/screen/main/map/component/list_button.dart';
import 'package:bookand/presentation/screen/main/map/component/map_utils.dart';
import 'package:bookand/presentation/screen/main/map/component/search_screen/components/search_top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//providers
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../component/bookmark_dialog.dart';
import '../../../../../provider/map/user_location_provider.dart';
import 'components/book_store_searched_tile.dart';
import 'components/no_search_text.dart';
import 'components/recommendation_button.dart';

class MapSearchScreen extends ConsumerStatefulWidget {
  static String get routeName => 'mapSearch';
  const MapSearchScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<MapSearchScreen> createState() => _MapSearchScreenState();
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

  bool showLocationPub = false;

  bool showEmptyScreen = false;

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
                children: (showEmptyScreen)
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
        statusBarColor: Colors.white,
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
            builder: (context) => Column(
              children: [
                SearchTopBar(
                  onFieldFocus: () {
                    setState(() {
                      isSearching = true;
                    });
                    ref.read(mapBottomSheetControllerProvider.notifier).close();
                  },
                  focusNode: focusNode,
                  controller: searchTextCon,

                  onChanged: (value) async {
                    setState(() {
                      searchingList = searchStores(value);
                      if (searchingList.isNotEmpty) {
                        setState(() {
                          showEmptyScreen = false;
                        });
                      }
                    });
                  },
                  // 검색 완료 시
                  onSubmitted: (value) {
                    setState(() {
                      //검색
                      searchedList = searchStores(value);
                      if (searchedList.isEmpty) {
                        setState(() {
                          showEmptyScreen = true;
                        });
                        return;
                      }
                      setState(() {
                        showEmptyScreen = false;
                      });
                      isSearching = false;
                      //마커 출력
                      markerSet = ref
                          .read(widgetMarkerNotiferProvider.notifier)
                          .getSearchedMarker(searchedList);
                      //검색된 것 중 가장 가까운 서점으로 카메라 이동
                      if (mapController != null) {
                        mapController!.animateCamera(CameraUpdate.newLatLngZoom(
                            LatLng(
                                (searchedList.first.latitude ??
                                        SEOUL_COORD_LAT) -
                                    LAT_FIXED,
                                searchedList.first.longitude ??
                                    SEOUL_COORD_LON),
                            DEFAULT_ZOOM));
                      }

                      ref
                          .read(mapBottomSheetControllerProvider.notifier)
                          .showSearchPageSheet(
                              context: context, bookstoreList: searchedList);

                      ref.read(mapListToggleProvider.notifier).activate();

                      ref
                          .read(mapButtonHeightNotifierProvider.notifier)
                          .updateHeight(
                              (MediaQuery.of(context).size.height) * 0.5);
                    });
                  },
                ),
                Expanded(
                  child: Stack(
                    children: [
                      GoogleMap(
                          myLocationEnabled: showLocationPub,
                          myLocationButtonEnabled: false,
                          zoomControlsEnabled: false,
                          mapToolbarEnabled: false,
                          onTap: (argument) {
                            ref
                                .read(widgetMarkerNotiferProvider.notifier)
                                .setAllNormal();
                          },
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
                              final bounds =
                                  await mapController?.getVisibleRegion();
                              if (bounds == null) {
                                return;
                              }

                              final inScreen =
                                  await MapUtils.getBookstoresInScreen(
                                      searchedList, bounds);
                              ref
                                  .read(
                                      mapBottomSheetControllerProvider.notifier)
                                  .showSearchPageSheet(
                                      context: context,
                                      bookstoreList: inScreen);
                            },
                            onDeactive: () {
                              ref
                                  .read(
                                      mapBottomSheetControllerProvider.notifier)
                                  .close();
                            },
                          )),
                      Positioned(
                          right: buttonPading,
                          bottom: buttonHeight + buttonPading,
                          child: GpsButton(
                            onAcitve: () async {
                              if (await ref
                                  .read(userLocationProviderProvider.notifier)
                                  .checkPermissionAndListen()) {
                                setState(() {
                                  showLocationPub = true;
                                });
                                final pos =
                                    ref.read(userLocationProviderProvider);
                                mapController?.animateCamera(
                                    CameraUpdate.newLatLngZoom(
                                        pos, DEFAULT_ZOOM));
                              } else {
                                await showDialog(
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
                                throw FlutterError('location permision denied');
                              }
                            },
                            onDeactive: () {
                              setState(() {
                                showLocationPub = false;
                              });
                            },
                          )),
                      //TODO for dev
                      // Positioned(
                      //   right: buttonPading,
                      //   bottom: buttonHeight + buttonPading + 2 * buttonSpace,
                      //   child: MapZoomOutButton(
                      //     controller: mapController,
                      //   ),
                      // ),
                      // Positioned(
                      //   right: buttonPading,
                      //   bottom: buttonHeight + buttonPading + 3 * buttonSpace,
                      //   child: MapZoomInButton(controller: mapController),
                      // ),
                      createSearchBody(),
                    ],
                  ),
                ),
              ],
            ),
          ))),
    );
  }

  List<BookStoreMapModel> searchStores(String data) {
    if (data.isEmpty) {
      return [];
    }
    List<BookStoreMapModel> all = ref.read(mapBookStoreNotifierProvider);
    //검색어 포함한 store 거리 순으로 정렬해서 리턴
    List<BookStoreMapModel> searched =
        all.where((element) => element.name!.contains(data)).toList();
    searched.sort((a, b) => a.userDistance!.compareTo(b.userDistance!));
    return searched;
  }
}
