// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:developer';
import 'dart:math' as math;

import 'package:bookand/core/const/enum_boomark_marker_type.dart';
import 'package:bookand/core/const/map.dart';
import 'package:bookand/core/util/common_util.dart';
import 'package:bookand/core/widget/base_layout.dart';
import 'package:bookand/core/widget/slide_icon.dart';
import 'package:bookand/domain/model/bookstore/bookstore_map_model.dart';
import 'package:bookand/presentation/provider/bookstore_manager.dart';
import 'package:bookand/presentation/provider/bookstore_marker_data_manager.dart';
import 'package:bookand/presentation/screen/main/map/component/gps_button.dart';
import 'package:bookand/presentation/screen/main/map/component/list_button.dart';
import 'package:bookand/presentation/screen/main/map/component/map_function_buttons.dart';
import 'package:bookand/presentation/screen/main/map/searched_components/book_store_searched_tile.dart';
import 'package:bookand/presentation/screen/main/map/searched_components/searched_top_bar.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../../component/bookmark_dialog.dart';

class MapSearchedScreen extends ConsumerStatefulWidget {
  static String get routeName => 'mapSearched';
  final String query;
  final List<BookStoreMapModel> searchedList;
  const MapSearchedScreen(
      {Key? key, required this.query, required this.searchedList})
      : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends ConsumerState<MapSearchedScreen> {
  bool isDeactvie = false;

  bool appBarIsLong = true;

  double buttonHeight = MAP_BUTTON_HEIGHT;
  // 바텀 시트 스타일
  EdgeInsets bottomSheetPadding = const EdgeInsets.symmetric(horizontal: 16);
  BorderRadius bottomSheetbr = const BorderRadius.only(
      topLeft: Radius.circular(24), topRight: Radius.circular(24));

  /// 버튼 상태
  bool gspStatus = false;
  bool listStatus = true;

  /// 버튼 상태

  // 맵
  GoogleMapController? mapController;
  bool showLocationPub = false;
  // 사용자 위치(location manager에서 갱신)
  LatLng? userPos;
  // 사용자 위치 갱신할 타이머
  Timer? locationTimer;

  // 출력할 리스트
  List<BookStoreMapModel> storeList = [];

  // 맵에 출력할 마커
  Set<Marker> markers = {};

  // 출력되는 바디의 높이
  double bodyHeight = 0;
  double minHeight = 0;
  double maxHeight = 0;

  // 리스트, 마커 탭 시 패널 조정할 컨트롤러
  PanelController panelController = PanelController();

  @override
  void initState() {
    storeList = List.from(widget.searchedList);
    markers = getInitMarkers(storeList, BookStoreMarkerType.basic);

    // 유저 위치
    initLocation();

    super.initState();
  }

  @override
  void deactivate() {
    isDeactvie = true;
    locationTimer?.cancel();
    locationTimer = null;
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    isDeactvie = false;
    if (bodyHeight == 0) {
      bodyHeight = MediaQuery.of(context).size.height -
          MediaQuery.of(context).padding.bottom -
          MediaQuery.of(context).padding.top -
          SearchedAppbar.height;

      // 슬라이딩 패널 최소 높이
      // + 18은 패딩
      minHeight = (bodyHeight * 0.5) >
              (storeList.length * BookStoreSearchedTile.height + 18)
          ? storeList.length * BookStoreSearchedTile.height + 18
          : bodyHeight * 0.5;
      minHeight = math.max(minHeight, 200);
      // 슬라이딩 패널 최고 높이
      maxHeight = (bodyHeight) - 18;
      buttonHeight = minHeight + 18;
      setState(() {});
    }
    // 마커 데이터 생성이 늦었을 때 갱신

    return SafeArea(
      child: BaseLayout(
        appBar: SearchedAppbar(
          query: widget.query,
          onTap: () {
            ref.context.pop();
          },
        ),
        backgroundColor: Colors.white,
        child: Stack(
          children: [
            // appbar 를 바텀리스트 위에 출력하기 위해 새로운 빌더로 생성
            SlidingUpPanel(
              controller: panelController,
              borderRadius: bottomSheetbr,
              boxShadow: [],
              minHeight: minHeight,
              // 스테이터스 바는 padding값이네?
              maxHeight: maxHeight,
              onPanelSlide: (position) {
                if (storeList.length == 1) {
                  return;
                }
                double height = maxHeight - minHeight + 18 + 18;
                setState(() {
                  buttonHeight = (height) * position + height;
                });
              },
              panelBuilder: (sc) {
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  controller: sc,
                  child: Column(
                    children: [
                      slideIcon,
                      ...storeList.map((e) => BookStoreSearchedTile(
                            model: e,
                            isSeaching: false,
                          ))
                    ],
                  ),
                );
              },
              body: GoogleMap(
                onTap: onMapTap,
                minMaxZoomPreference:
                    const MinMaxZoomPreference(MIN_ZOOM, MAX_ZOOM),
                myLocationEnabled: showLocationPub,
                myLocationButtonEnabled: false,
                mapToolbarEnabled: false,
                zoomControlsEnabled: false,
                onMapCreated: (controller) {
                  setState(() {
                    mapController = controller;
                  });
                  // 모든 서점 보이게 맵 조정
                  LatLngBounds? targetBound = CommonUtil.getBoundsWithList(
                      widget.searchedList
                          .map((e) => LatLng(e.latitude ?? SEOUL_COORD_LAT,
                              e.longitude ?? SEOUL_COORD_LON))
                          .toList());
                  if (targetBound != null) {
                    double distance = Geolocator.distanceBetween(
                        targetBound.northeast.latitude,
                        targetBound.northeast.longitude,
                        targetBound.southwest.latitude,
                        targetBound.southwest.longitude);
                    // 제일 멀리 떨어진 게 500M는 되면 카메라 조정 아니면 첫번째 서점 위치로
                    if (distance > 500) {
                      //TODO 실제 데이터 들어가서 시트 안가리는지 체크 필요, 패딩 값 어떻게 적용되는지 체크 필요
                      mapController?.animateCamera(
                          CameraUpdate.newLatLngBounds(targetBound, 60));
                    } else {
                      mapController?.animateCamera(CameraUpdate.newLatLngZoom(
                          LatLng(
                              (widget.searchedList.first.latitude ??
                                      SEOUL_COORD_LAT) -
                                  LAT_FIXED,
                              widget.searchedList.first.longitude ??
                                  SEOUL_COORD_LON),
                          DEFAULT_ZOOM));
                    }
                  }
                },
                markers: markers,
                initialCameraPosition: const CameraPosition(
                    target: LatLng(SEOUL_COORD_LAT, SEOUL_COORD_LON),
                    zoom: DEFAULT_ZOOM),
              ),
            ),

            // 버튼들
            Positioned(
                right: MAP_BUTTON_PADDING,
                bottom: buttonHeight,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // TODO DEV
                    MapZoomInButton(
                      controller: mapController,
                    ),
                    const SizedBox(
                      height: MAP_BUTTON_MARGIN,
                    ),
                    MapZoomOutButton(
                      controller: mapController,
                    ),
                    // TODO DEV
                    const SizedBox(
                      height: MAP_BUTTON_MARGIN,
                    ),
                    ListButton(
                      status: listStatus,
                      onTap: () {
                        if (panelController.isAttached) {
                          panelController.close();
                        }
                        // 꺼지면 storeList 비우기, 패널 드래그 못하게
                        if (listStatus) {
                          minHeight = 40;
                          maxHeight = 40;
                          storeList.clear();
                          listStatus = false;
                        } else {
                          // 켜지면 storelist 원래 받은 리스트, 최소 크기 조정
                          storeList = List.from(widget.searchedList);
                          maxHeight = (bodyHeight) - 18;
                          minHeight = (bodyHeight * 0.5) >
                                  (storeList.length *
                                          BookStoreSearchedTile.height +
                                      18)
                              ? storeList.length *
                                      BookStoreSearchedTile.height +
                                  18
                              : bodyHeight * 0.5;
                          listStatus = true;
                        }
                        setState(() {
                          buttonHeight = minHeight + 18;
                        });
                      },
                    ),
                    const SizedBox(
                      height: MAP_BUTTON_MARGIN,
                    ),
                    GpsButton(
                      selected: gspStatus,
                      onTap: () async {
                        if (gspStatus) {
                          setState(() {
                            showLocationPub = false;
                            gspStatus = false;
                          });
                        } else {
                          try {
                            userPos ??= await _getCurrentPosition();
                            if (userPos == null) {
                              setState(() {
                                gspStatus = false;
                              });
                              return;
                            }
                            await mapController?.animateCamera(
                                CameraUpdate.newLatLngZoom(
                                    userPos!, DEFAULT_ZOOM));
                            setState(() {
                              showLocationPub = true;
                              gspStatus = true;
                            });
                          } catch (e) {
                            log('MapScreen, animateCamera e = $e');
                          }
                        }
                      },
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }

  void onMapTap(LatLng pos) {
    setAllMarker(BookStoreMarkerType.basic);
  }

  Set<Marker> getInitMarkers(
      List<BookStoreMapModel> bookStoreList, BookStoreMarkerType type) {
    // 타입 별 id 리스트 갱신
    return _getMarkers(bookStoreList, type);
  }

  Set<Marker> _getMarkers(
      List<BookStoreMapModel> bookStoreList, BookStoreMarkerType type) {
    Set<Marker> markers = {};
    if (!ref.read(bookStoreMarkerDataManagerProvider.notifier).isInited) {
      return markers;
    }
    for (var bookStore in bookStoreList) {
      BitmapDescriptor? iconData = ref
          .read(bookStoreMarkerDataManagerProvider.notifier)
          .getMarkerData(bookStore.id ?? -1, type);
      if (iconData != null) {
        markers.add(_createMarker(bookStore, iconData));
      }
    }
    return markers;
  }

  Marker _createMarker(
    BookStoreMapModel bookStore,
    BitmapDescriptor iconData,
  ) {
    return Marker(
        markerId: MarkerId((bookStore.id ?? -1).toString()),
        icon: iconData,
        onTap: () {
          onTapMarker(
              bookStore.id ?? -1,
              LatLng(bookStore.latitude ?? SEOUL_COORD_LAT,
                  bookStore.longitude ?? SEOUL_COORD_LON));
        },
        position: LatLng(bookStore.latitude ?? SEOUL_COORD_LAT,
            bookStore.longitude ?? SEOUL_COORD_LON),
        zIndex: MARKER_ZINDEX);
  }

  // id로 생성된 마커를 타입으로 변경
  Marker? setMarkerNewType(int id, BookStoreMarkerType newType, double zIndex) {
    final markerManager = ref.read(bookStoreMarkerDataManagerProvider.notifier);
    Marker? targetMarker;
    for (var element in markers) {
      if (element.mapsId.value == id.toString()) {
        targetMarker = element;
      }
    }
    if (targetMarker != null) {
      BitmapDescriptor? newIconData = markerManager.getMarkerData(id, newType);

      final newMarker =
          targetMarker.copyWith(iconParam: newIconData, zIndexParam: zIndex);
      markers.remove(targetMarker);
      markers.add(newMarker); // big marker zInex, inconData 변경

      setState(() {
        markers = markers;
      });
      return newMarker;
    }
    return null;
  }

  /// 마커 클릭 콜백 현재 북마크 상태에 따름
  /// 다른 마커는 작은 마커로 변경
  /// 대상은 큰 마커 타입으로 아이콘 변경
  void onTapMarker(int id, LatLng coord) {
    // 여기선 받은 리스트 대상으로 검색
    BookStoreMapModel? target =
        widget.searchedList.firstWhereOrNull((element) => element.id == id);
    if (target == null) {
      return;
    }
    setAllMarker(BookStoreMarkerType.basic);
    setMarkerNewType(id, BookStoreMarkerType.big, BIG_MARKER_ZINDEX);
    // 바텀시트 안가리게 이동
    mapController?.animateCamera(CameraUpdate.newLatLngZoom(
        LatLng(coord.latitude - LAT_FIXED, coord.longitude), DEFAULT_ZOOM));

    setState(() {
      listStatus = true;
      storeList = [target];
      minHeight = 200;
      buttonHeight = minHeight + 18;
      maxHeight = minHeight;
    });
  }

  /// 모든 마커를 해당 타입의 아이콘으로 변경, zIndex는 기본값으로, withHide가 true이면 hide도 초기화
  void setAllMarker(BookStoreMarkerType type) {
    if (isDeactvie) {
      return;
    }
    final markerManager = ref.read(bookStoreMarkerDataManagerProvider.notifier);

    final newMarkers = markers
        .map((e) => e.copyWith(
            iconParam: markerManager.getMarkerData(
                int.tryParse(e.markerId.value) ?? -1, type),
            zIndexParam: MARKER_ZINDEX))
        .toSet();
    setState(() {
      markers = newMarkers;
    });
  }

  Future initLocation() async {
    setLocation();
    _initLocationTimer(LOCATION_SEARCH_INTERVAL);
  }

  Future setLocation() async {
    if (isDeactvie) {
      return;
    }
    userPos = await _getCurrentPosition();
    if (isDeactvie) {
      return;
    }
    if (userPos != null) {
      ref
          .read(bookStoreManagerProvider.notifier)
          .patchStoresDistanceBetweenUser(userPos!);
    }
  }

  void _initLocationTimer(int renewalMin) {
    locationTimer?.cancel();
    locationTimer =
        Timer.periodic(Duration(minutes: renewalMin), (timer) async {
      setLocation();
    });
  }

  Future<LatLng?> _getCurrentPosition({bool showDialogOption = true}) async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return null;
      }
      bool permission =
          await _checkPermission(showDialogOption: showDialogOption);
      if (!permission) {
        return null;
      }
      Position position = await Geolocator.getCurrentPosition();
      return LatLng(position.latitude, position.longitude);
    } catch (e) {
      log('MapScreen, e = $e');
      return null;
    }
  }

  Future<bool> _checkPermission({bool showDialogOption = true}) async {
    LocationPermission permision = await Geolocator.checkPermission();
    if (permision != LocationPermission.always &&
        permision != LocationPermission.whileInUse) {
      permision = await Geolocator.requestPermission();
    }
    if (permision != LocationPermission.always &&
        permision != LocationPermission.whileInUse) {
      if (permision == LocationPermission.deniedForever && showDialogOption) {
        await showDialog(
            context: context,
            builder: (context) => BookmarkDialog(
                  title: 'Gsp 권한 설정',
                  description: '해당 기능을 사용하기 위해선 Gps 권한 설정이 필요합니다.',
                  leftButtonString: '취소',
                  rightButtonString: '설정',
                  onLeftButtonTap: () {
                    context.pop();
                  },
                  onRightButtonTap: () {
                    context.pop();
                    Geolocator.openAppSettings();
                  },
                ));
      }
      return false;
    }
    return true;
  }
}
