// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:developer';

import 'package:bookand/core/const/enum_boomark_marker_type.dart';
import 'package:bookand/core/const/map.dart';
import 'package:bookand/domain/model/bookstore/bookstore_map_model.dart';
import 'package:bookand/presentation/provider/bookstore_hide_recommendation_provider.dart';
import 'package:bookand/presentation/provider/bookstore_in_map_provider.dart';
import 'package:bookand/presentation/provider/bookstore_manager.dart';
import 'package:bookand/presentation/provider/bookstore_marker_data_manager.dart';
import 'package:bookand/presentation/screen/main/map/component/gps_button.dart';
import 'package:bookand/presentation/screen/main/map/component/list_button.dart';
import 'package:bookand/presentation/screen/main/map/component/map_function_buttons.dart';
import 'package:bookand/presentation/screen/main/map/component/theme_utils.dart';
import 'package:bookand/presentation/screen/main/map/map_app_bar.dart';
import 'package:bookand/presentation/screen/main/map/map_app_bar_components/hide_book_store_button.dart';
import 'package:bookand/presentation/screen/main/map/map_app_bar_components/map_appbar_book_mark_button.dart';
import 'package:bookand/presentation/screen/main/map/map_app_bar_components/theme_button.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/widget/slide_icon.dart';
import '../../../../gen/assets.gen.dart';
import '../../../component/bookmark_dialog.dart';
import '../../../component/bookstore_snackbar.dart';
import 'component/book_store_tile.dart';
import 'component/map_utils.dart';
import 'component/refresh_button.dart';
import 'component/theme_bottom_sheet.dart';
import 'map_app_bar_components/search_field.dart';
import 'map_searching_screen.dart';

class MapScreen extends ConsumerStatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends ConsumerState<MapScreen> {
  bool isDeactvie = false;

  bool appBarIsLong = true;

  double buttonHeight = MAP_BUTTON_HEIGHT;
  // 바텀 시트 스타일
  EdgeInsets bottomSheetPadding = const EdgeInsets.symmetric(horizontal: 16);
  BorderRadius bottomSheetbr = const BorderRadius.only(
      topLeft: Radius.circular(24), topRight: Radius.circular(24));

  /// 버튼 상태
  bool gspStatus = false;
  bool listStatus = false;
  bool showBookmark = false;
  bool showHideRecommendation = false;

  /// 버튼 상태

  // 맵
  GoogleMapController? mapController;
  bool showLocationPub = false;
  // 맵 이동할 때 마다 검색할 때 마지막 검색한 시간
  DateTime storesInMapTime = DateTime.now();
  // 사용자 위치(location manager에서 갱신)
  LatLng? userPos;
  // 사용자 위치 갱신할 타이머
  Timer? locationTimer;

  // 선택한 테마
  List<Themes> selectedThemes = [];

  // 적용 대상 서점 리스트(북마크, 테마 여부에 따라 변경됨)
  List<BookStoreMapModel> storeList = [];
  // 맵에 출력할 마커
  Set<Marker> markers = {};

  // 출력중인 바텀시트
  PersistentBottomSheetController? renderingSheet;
  // 이미 출력 중인데 새로 출력하면 이전 시트의 종료 콜백은 작동안함
  bool overwriteBottomSheet = false;

  // 바텀시트 출력할 inner
  late BuildContext innereBuildContext;

  @override
  void initState() {
    innereBuildContext = context;
    storeList = ref.read(bookStoreManagerProvider);
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
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      renderingSheet?.close();
      renderingSheet = null;
    });
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    isDeactvie = false;

    // 마커 데이터 생성이 늦었을 때 갱신
    ref.listen(bookStoreMarkerDataManagerProvider, (previous, next) {
      setState(() {
        markers = getInitMarkers(storeList, BookStoreMarkerType.basic);
      });
    });
    // 북마크 등 변경사항 생기면 갱신
    ref.listen(bookStoreManagerProvider, (previous, next) {
      onBookstoreStatusUpdate();
    });

    return Scaffold(
      appBar: MapAppBar(
          isLong: appBarIsLong,
          searchButton: renderSearchButton(),
          bottomButtons: [
            renderBookmarkButton(),
            const SizedBox(
              width: 8,
            ),
            renderThemeButton(),
            const Spacer(),
            Container(
              margin: const EdgeInsets.all(10),
              width: 1,
              height: 16,
              color: const Color(0xffdddddd),
            ),
            renderHideBookStoreButton()
          ]),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // appbar 를 바텀리스트 위에 출력하기 위해 새로운 빌더로 생성
          Scaffold(
            backgroundColor: Colors.transparent,
            body: Builder(
              builder: (inner) {
                innereBuildContext = inner;
                return Listener(
                  onPointerMove: (event) {
                    setState(() {
                      gspStatus = false;
                    });
                  },
                  child: GoogleMap(
                    minMaxZoomPreference:
                        const MinMaxZoomPreference(MIN_ZOOM, MAX_ZOOM),
                    gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
                      Factory<OneSequenceGestureRecognizer>(
                          () => EagerGestureRecognizer())
                    },
                    myLocationEnabled: showLocationPub,
                    myLocationButtonEnabled: false,
                    mapToolbarEnabled: false,
                    zoomControlsEnabled: false,
                    onMapCreated: (controller) {
                      setState(() {
                        mapController = controller;
                      });
                    },
                    markers: markers,
                    initialCameraPosition: const CameraPosition(
                        target: LatLng(SEOUL_COORD_LAT, SEOUL_COORD_LON),
                        zoom: DEFAULT_ZOOM),
                    onCameraMove: onMapMove,
                  ),
                );
              },
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
                      if (listStatus) {
                        renderingSheet?.close();
                        setState(() {
                          buttonHeight = MAP_BUTTON_HEIGHT;
                          listStatus = false;
                          showHideRecommendation = false;
                        });
                      } else {
                        showStoreInMapSheet();
                      }
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
    );
  }

  Widget renderSearchButton() {
    return SearchField(
      onTap: () {
        ref.context.pushNamed(MapSearchingScreen.routeName).then((value) {
          // 돌아올 때 데이터
          if (value == SEARCH_WAS_EMPTY) {
            showHideRecommendationSheet();
          }
        });
      },
    );
  }

  Widget renderBookmarkButton() {
    return MapAppbarBookMarkButton(
      status: showBookmark,
      onTap: () {
        if (showBookmark) {
          setState(() {
            showBookmark = false;
          });
        } else {
          setState(() {
            showBookmark = true;
          });
        }
        onBookstoreStatusUpdate();
      },
    );
  }

  Widget renderThemeButton() {
    return ThemeButton(
        onClear: () {
          setState(() {
            selectedThemes.clear();
          });
          onBookstoreStatusUpdate();
        },
        onTap: () {
          readyShowSheet();
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return ThemeBottomSheet(
                onApply: (newSelectedThemes) {
                  setState(() {
                    selectedThemes = newSelectedThemes;
                  });
                  onBookstoreStatusUpdate();
                },
                selectedThemes: selectedThemes,
              );
            },
          );
        },
        selectedThemes: selectedThemes);
  }

  Widget renderHideBookStoreButton() {
    return HideBookStoreButton(
      onTap: () {
        if (showHideRecommendation) {
          renderingSheet?.close();
          setState(() {
            showHideRecommendation = false;
          });
        } else {
          showHideRecommendationSheet();

          setState(() {
            showHideRecommendation = true;
          });
        }
      },
      status: showHideRecommendation,
    );
  }

  // 현재 페이지의 북마크 상태, 테마 상태에 따라 book store list 및 마커를 갱신함
  void onBookstoreStatusUpdate() {
    storeList = ref.read(bookStoreManagerProvider);
    // 북마크 여부 필터링
    if (showBookmark) {
      storeList =
          storeList.where((element) => element.isBookmark == true).toList();
    }

    if (selectedThemes.isNotEmpty) {
      // 테마 여부 필터링
      storeList = storeList
          .where((element) => selectedThemes.every((selectedTheme) =>
              element.theme?.contains(selectedTheme) ?? false))
          .toList();
    }

    if (storeList.isEmpty) {
      // 찾을 수 있는 서점이 없으면 마커 없애고 정보 시트 출력
      setState(() {
        markers = {};
      });
      showNoStoreSheet();
      return;
    }

    markers = getMarkers(
        storeList,
        showBookmark
            ? BookStoreMarkerType.bookmark
            : BookStoreMarkerType.basic);

    updateStoreInMap();

    setState(() {
      storeList = storeList;
      markers = markers;
    });
  }

  // 카메라가 이동할 때 마다 현재 맵에 출력되는 서점 목록 갱신, 맵안에 출력되는 게 없으면 그대로 유지
  void onMapMove(CameraPosition pos) async {
    if (isDeactvie) {
      return;
    }

    if (DateTime.now().difference(storesInMapTime).inMilliseconds >
        STORES_IN_MAP_INTERVAL) {
      await updateStoreInMap();
      storesInMapTime = DateTime.now();
    }
  }

  Future updateStoreInMap() async {
    try {
      final bounds = await mapController?.getVisibleRegion();
      if (bounds == null) {
        return;
      }
      final storeInMapList =
          await MapUtils.getBookstoresInScreen(storeList, bounds);
      if (isDeactvie) {
        return;
      }
      // 바텀시트가 출력중일 때는 비어있어도 바로 반영안함
      if (renderingSheet != null && storeInMapList.isEmpty) {
        return;
      }
      if (isDeactvie) {
        return;
      }
      ref
          .read(bookstoreInMapProividerProvider.notifier)
          .patchList(storeInMapList);
    } catch (e) {
      log('MapScreen, updateStoreInMap e = $e');
    }
  }

  Set<Marker> getInitMarkers(
      List<BookStoreMapModel> bookStoreList, BookStoreMarkerType type) {
    // 타입 별 id 리스트 갱신
    return getMarkers(bookStoreList, type);
  }

  Set<Marker> getMarkers(
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
        markers.add(createMarker(bookStore, iconData));
      }
    }
    return markers;
  }

  Marker createMarker(
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
    BookStoreMapModel? target =
        storeList.firstWhereOrNull((element) => element.id == id);
    if (target == null) {
      return;
    }
    // 바텀시트 안가리게 이동
    mapController?.animateCamera(CameraUpdate.newLatLngZoom(
        LatLng(coord.latitude - LAT_FIXED, coord.longitude), DEFAULT_ZOOM));
    showSingleStoreSheet(target);
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

  void readyShowSheet() {
    if (renderingSheet != null) {
      overwriteBottomSheet = true;

      setState(() {
        showHideRecommendation = false;
        listStatus = false;
        buttonHeight = MAP_BUTTON_HEIGHT;
      });

      renderingSheet?.close();
      renderingSheet = null;
      if (showBookmark) {
        setAllMarker(BookStoreMarkerType.bookmark);
      } else {
        setAllMarker(BookStoreMarkerType.basic);
      }
    } else {
      overwriteBottomSheet = false;
    }
  }

  void onSheetClose() {
    if (isDeactvie) {
      return;
    }
    if (overwriteBottomSheet) {
      overwriteBottomSheet = false;
      return;
    }
    renderingSheet = null;
    setState(() {
      showHideRecommendation = false;
      listStatus = false;
      buttonHeight = MAP_BUTTON_HEIGHT;
    });
    if (showBookmark) {
      setAllMarker(BookStoreMarkerType.bookmark);
    } else {
      setAllMarker(BookStoreMarkerType.basic);
    }
  }

  // 클릭한 한 서점만 출력
  void showSingleStoreSheet(BookStoreMapModel target) async {
    readyShowSheet();

    setState(() {
      buttonHeight = STORE_SHEET_HEIGHT;
      listStatus = true;
    });

    if (target.id == null) {
      return;
    }
    if (showBookmark) {
      setMarkerNewType(
          target.id!, BookStoreMarkerType.bookmarkBig, BIG_MARKER_ZINDEX);
    } else {
      setMarkerNewType(target.id!, BookStoreMarkerType.big, BIG_MARKER_ZINDEX);
    }

    //바텀 시트 출력
    renderingSheet = Scaffold.of(context).showBottomSheet((context) {
      renderingSheet?.closed.then((value) {
        onSheetClose();
      });
      return renderSingleStoreBottomSheet(target);
    }, backgroundColor: Colors.white);
  }

  /// 현재 맵에 출력중인 서점 바텀시트로 출력
  void showStoreInMapSheet() async {
    readyShowSheet();

    List<BookStoreMapModel> targetList =
        ref.read(bookstoreInMapProividerProvider);

    //버튼 높이 조정
    if (targetList.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(createSnackBar(data: '현 위치에 해당하는 서점이 없어요'));
      setState(() {
        listStatus = false;
        buttonHeight = MAP_BUTTON_HEIGHT;
      });
      return;
    }

    if (targetList.length == 1) {
      buttonHeight = STORE_SHEET_HEIGHT;
    } else if (targetList.length == 2) {
      buttonHeight = STORE_SHEET_HEIGHT;
    } else {
      buttonHeight = STORE_SHEET_HEIGHT;
    }
    setState(() {
      buttonHeight = buttonHeight;
      listStatus = true;
    });

    //바텀 시트 출력
    renderingSheet =
        Scaffold.of(innereBuildContext).showBottomSheet((innereBuildContext) {
      renderingSheet?.closed.then((value) {
        onSheetClose();
      });
      return renderStoresBottomSheet();
    }, backgroundColor: Colors.white);
  }

  /// 숨은 서점 출력할 때
  void showHideRecommendationSheet() async {
    readyShowSheet();

    BookStoreMapModel? target = ref
        .read(bookstoreHideRecommendationProividerProvider.notifier)
        .refreshRandomStore(storeList);
    if (target == null) {
      return;
    }

    setMarkerNewType(
        target.id!, BookStoreMarkerType.hideRecommend, BIG_MARKER_ZINDEX);

    if (target.latitude == null && target.longitude == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(createSnackBar(data: '서점의 위치를 찾을 수 없습니다. 다시 시도해주세요'));
      return;
    }
    // 바텀시트 안가리게 이동
    mapController?.animateCamera(CameraUpdate.newLatLngZoom(
        LatLng(target.latitude! - LAT_FIXED, target.longitude!), DEFAULT_ZOOM));

    setState(() {
      showHideRecommendation = true;
      buttonHeight = HIDE_RECOMMENDATION_SHEET_HEIGHT + MAP_BUTTON_HEIGHT;
      listStatus = true;
    });

    renderingSheet = showBottomSheet(
      context: context,
      builder: (context) {
        renderingSheet?.closed.then((value) {
          onSheetClose();
        });
        return renderHideRecommendationSheet();
      },
    );
  }

  Widget renderSingleStoreBottomSheet(BookStoreMapModel target) {
    return Consumer(
      builder: (context, ref, child) {
        return Container(
            decoration:
                BoxDecoration(color: Colors.white, borderRadius: bottomSheetbr),
            padding: bottomSheetPadding,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [slideIcon, BookStoreTile(store: target)],
            ));
      },
    );
  }

  Widget renderStoresBottomSheet() {
    return Consumer(
      builder: (context, ref, child) {
        List<BookStoreMapModel> targetList =
            ref.watch(bookstoreInMapProividerProvider);
        if (targetList.isEmpty) {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            renderingSheet?.close();
          });
          return SizedBox();
        }
        return targetList.length < 3
            ? Container(
                decoration: BoxDecoration(
                    color: Colors.white, borderRadius: bottomSheetbr),
                padding: bottomSheetPadding,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    slideIcon,
                    ...targetList.map((e) => BookStoreTile(store: e)).toList()
                  ],
                ))
            : StatefulBuilder(
                builder: (context, innerSetState) {
                  bool isOpend = false;
                  double maxHeight = MediaQuery.of(context).size.height -
                      MAP_APPBAR_LONG_HEIGHT -
                      // MediaQuery.of(context).padding.bottom -
                      // MediaQuery.of(context).viewInsets.bottom -
                      // MediaQuery.of(context).padding.top -
                      // MediaQuery.of(context).viewInsets.top -
                      kBottomNavigationBarHeight;
                  return NotificationListener<DraggableScrollableNotification>(
                    onNotification:
                        (DraggableScrollableNotification dsNotification) {
                      setState(() {
                        buttonHeight = (maxHeight) * dsNotification.extent;
                      });
                      //바텀 시트가 완전히 펼쳐졌을 때 br, slide icon 조정을 위한 감지
                      if (!isOpend && dsNotification.extent >= 1) {
                        innerSetState(() {
                          isOpend = true;
                        });
                      } else if (isOpend && dsNotification.extent < 1) {
                        innerSetState(() {
                          isOpend = false;
                        });
                      }
                      return false;
                    },
                    child: DraggableScrollableSheet(
                        initialChildSize: STORE_SHEET_HEIGHT / maxHeight,
                        expand: false,
                        builder: (context, scrollController) {
                          // 앱 바 높이 조정
                          scrollController.addListener(() {
                            if (scrollController.offset > 0.2) {
                              if (scrollController
                                      .position.userScrollDirection ==
                                  ScrollDirection.forward) {
                                setState(() {
                                  appBarIsLong = true;
                                });
                              } else if (scrollController
                                      .position.userScrollDirection ==
                                  ScrollDirection.reverse) {
                                setState(() {
                                  appBarIsLong = false;
                                });
                              }
                            }
                          });
                          return SingleChildScrollView(
                            physics: isOpend
                                ? null
                                : const NeverScrollableScrollPhysics(),
                            controller: scrollController,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: isOpend ? null : bottomSheetbr),
                              width: MediaQuery.of(context).size.width,
                              padding: bottomSheetPadding,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  isOpend ? const SizedBox() : slideIcon,
                                  ...targetList
                                      .map((e) => BookStoreTile(store: e))
                                      .toList()
                                ],
                              ),
                            ),
                          );
                        }),
                  );
                },
              );
      },
    );
  }

  Widget renderHideRecommendationSheet() {
    return Consumer(
      builder: (context, ref, child) {
        BookStoreMapModel? target =
            ref.watch(bookstoreHideRecommendationProividerProvider);
        if (target == null) {
          return SizedBox();
        }
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: bottomSheetbr,
          ),
          padding: bottomSheetPadding,
          height: HIDE_RECOMMENDATION_SHEET_HEIGHT,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              slideIcon,
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '당신을 위한 보석같은 서점 추천',
                    style: TextStyle(
                      color: Color(0xFF222222),
                      fontSize: 18,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.36,
                    ),
                  ),
                  RefreshButton(
                    onTap: () {
                      final newTarget = ref
                          .read(bookstoreHideRecommendationProividerProvider
                              .notifier)
                          .refreshRandomStore(storeList);
                      if (newTarget?.latitude == null ||
                          newTarget?.longitude == null ||
                          newTarget?.id == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            createSnackBar(
                                data: '서점의 정보를 찾을 수 없습니다. 다시 시도해주세요'));
                      }
                      if (showBookmark) {
                        setAllMarker(BookStoreMarkerType.bookmark);
                      } else {
                        setAllMarker(BookStoreMarkerType.basic);
                      }

                      setMarkerNewType(newTarget!.id!,
                          BookStoreMarkerType.hideRecommend, BIG_MARKER_ZINDEX);
                      // 바텀시트 안가리게 이동
                      mapController?.animateCamera(CameraUpdate.newLatLngZoom(
                          LatLng(
                              target.latitude! - LAT_FIXED, target.longitude!),
                          DEFAULT_ZOOM));
                    },
                  )
                ],
              ),
              BookStoreTile(
                store: target,
              )
            ],
          ),
        );
      },
    );
  }

  void showNoStoreSheet() {
    readyShowSheet();

    setState(() {
      buttonHeight = HIDE_RECOMMENDATION_SHEET_HEIGHT + MAP_BUTTON_HEIGHT;
    });

    renderingSheet = showBottomSheet(
      context: context,
      builder: (context) {
        renderingSheet?.closed.then((value) {
          onSheetClose();
        });
        return renderNoStore();
      },
    );
  }

  Widget renderNoStore() {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration:
          BoxDecoration(color: Colors.white, borderRadius: bottomSheetbr),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 11,
          ),
          slideIconWithNoMargin,
          const SizedBox(
            height: 45,
          ),
          SvgPicture.asset(
            Assets.images.icWarning,
            width: 36,
            height: 36,
          ),
          const SizedBox(
            height: 8,
          ),
          const Text(
            '찾으시는 서점이 없어요',
            style: TextStyle(
              color: Color(0xFF565656),
              fontSize: 14,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w500,
              height: 1.50,
              letterSpacing: -0.28,
            ),
          ),
          const SizedBox(
            height: 41,
          ),
          getNewStoreButton(),
          const SizedBox(
            height: 60,
          ),
        ],
      ),
    );
  }

  Widget getNewStoreButton() {
    return GestureDetector(
      onTap: () {
        showBookmark = false;
        selectedThemes.clear();
        onBookstoreStatusUpdate();
        showHideRecommendationSheet();
      },
      child: Container(
        width: 328,
        height: 56,
        alignment: Alignment.center,
        decoration: ShapeDecoration(
          color: const Color(0xFF222222),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: const Text(
          '새로운 서점 추천 받기',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontFamily: 'Pretendard',
            fontWeight: FontWeight.w500,
            height: 1.50,
            letterSpacing: -0.64,
          ),
        ),
      ),
    );
  }
}
