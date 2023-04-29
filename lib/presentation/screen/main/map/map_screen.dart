import 'dart:math';

import 'package:bookand/core/const/map.dart';
import 'package:bookand/core/util/common_util.dart';
import 'package:bookand/core/widget/slide_icon.dart';
import 'package:bookand/domain/model/bookstore/bookstore_map_model.dart';
import 'package:bookand/presentation/provider/map/geolocator_position_provider.dart';
import 'package:bookand/presentation/provider/map/map_bookstores_provider.dart';
import 'package:bookand/presentation/provider/map/map_bools_providers.dart';
import 'package:bookand/presentation/provider/map/map_button_height_provider.dart';
import 'package:bookand/presentation/provider/map/map_controller_provider.dart';
import 'package:bookand/presentation/provider/map/map_filtered_book_store_provider.dart';
import 'package:bookand/presentation/provider/map/map_panel_visible_provider.dart';
import 'package:bookand/presentation/provider/map/widget_marker_provider.dart';
import 'package:bookand/presentation/screen/main/map/component/theme_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
//providers
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../../../core/widget/base_layout.dart';
//components
import 'component/book_store_tile.dart';
import 'component/gps_button.dart';
import 'component/list_button.dart';
import 'component/refresh_button.dart';
import 'component/top_bar/top_bar.dart';

class MapScreen extends ConsumerStatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

enum CustomPanelState { opend, closed }

class _MapScreenState extends ConsumerState<MapScreen> {
  // 버튼 하단, 오른쪽  패딩
  final double buttonPading = 15;
  //버튼 사이의 간격
  final double buttonSpace = 40;
  //sidle panel 슬라이딩 패널
  final double slideBraidus = 24;
  // slide max height는 기기 최대 크기
  final double slideMinHeight = MapButtonHeightNotifier.panelHeight;

  // init camera
  static CameraPosition initCamera =
      CameraPosition(target: LatLng(SEOUL_COORD[0], SEOUL_COORD[1]), zoom: 13);

  //textstyles
  final TextStyle hideTitle = const TextStyle(
      fontSize: 18, fontWeight: FontWeight.w700, color: Color(0xff222222));

  //varibable
  CustomPanelState panelState = CustomPanelState.closed;
  // panel state에서 관리하려고 하면 open -> scrolling으로 갈 때 오류가 나서 분리
  bool panelScrolling = false;

  bool inited = false;
  bool markInited = false;
  //서버에서 받은 모든 bookstroes
  List<BookStoreMapModel> bookstores = [];
  //조건 처리된 bookstores
  List<BookStoreMapModel> filteredBookstroes = [];
  //현재 화면 안에 있는 bookstores
  List<BookStoreMapModel> bookstoresInScreen = [];

  void updatePanelState(CustomPanelState state) {
    if (panelState != state) {
      setState(() {
        panelState = state;
      });
    }
  }

  // 가지고 있는 서점에서 해당하지 않는 것들을 제거하는 방식으로 초기화
  Future initFilteredBookstroes(
      {required bool isBookmark, required List<Themes> selectedThemes}) async {
    filteredBookstroes = List.from(bookstores);
    if (isBookmark) {
      filteredBookstroes.removeWhere((element) => element.isBookmark == false);
    }
    if (selectedThemes.isNotEmpty) {
      //store의 테마가 없으면 제거 (좀 더 비교 대상 줄이기)
      filteredBookstroes
          .removeWhere((bookstore) => bookstore.theme?.isEmpty ?? true);
      //체크한 테마 개수랑 store  테마 개수 안맞으면 제거(좀 더 비교 대상 줄이기)
      filteredBookstroes.removeWhere(
          (bookstore) => bookstores.length != filteredBookstroes.length);
      filteredBookstroes.removeWhere((bookstore) {
        for (Themes theme in selectedThemes) {
          if (bookstore.theme!.contains(theme)) {
            return false;
          } else {
            return true;
          }
        }
        return false;
      });
    }
    //마커 출력
    ref
        .read(widgetMarkerNotiferProvider.notifier)
        .setBookstoreMarker(filteredBookstroes);
  }

  void panelClosed() {
    updatePanelState(CustomPanelState.closed);
  }

  void panelOpend() {
    updatePanelState(CustomPanelState.opend);
  }

  void isPanelScrolling() {
    if (panelScrolling == false) {
      setState(() {
        panelScrolling = true;
      });
    }
  }

  void isNotPanelScrolling() {
    if (panelScrolling == true) {
      setState(() {
        panelScrolling = false;
      });
    }
  }

  @override
  void initState() {
    init();

    super.initState();
  }

//bookstore를 서버에서 받고 초기화 후 마커 출력
  Future init() async {
    final userCoord = await ref
        .read(gelolocatorPostionNotifierProvider.notifier)
        .getCurrentPosition();
    //카메라 이동
    ref
        .read(mapControllerNotiferProvider.notifier)
        .moveCamera(lat: userCoord.lat, lng: userCoord.lng);
    // 서버에서 받음.
    await ref
        .read(mapBooksStoreNotifierProvider.notifier)
        .fetchBookstoreList(userLat: userCoord.lat, userLon: userCoord.lng);
    // bookstores 초기화
    bookstores = ref.read(mapBooksStoreNotifierProvider);
    // filteredbookstores 초기화
    ref
        .read(mapFilteredBooksStoreNotifierProvider.notifier)
        .filteredBookstroes(isBookmark: false, selectedThemes: []);
    filteredBookstroes = ref.read(mapFilteredBooksStoreNotifierProvider);
    //마커 출력
    ref
        .read(widgetMarkerNotiferProvider.notifier)
        .initMarkers(filteredBookstroes);
    inited = true;
  }

  //랜덤으로 하나 잡아서 타일 만듬
  Widget getHideStoreContent() {
    final randomIndex = Random().nextInt(bookstores.length);
    final randomModel = bookstores[randomIndex];
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('당신을 위한 보석같은 서점 추천', style: hideTitle),
            const RefreshButton()
          ],
        ),
        BookStoreTile(
          store: randomModel,
        )
      ],
    );
  }

  Widget getListContent() {
    return Column(
      children: bookstores.map((e) => BookStoreTile(store: e)).toList(),
    );
  }

  Widget getPanelContent([bool isHideStore = false]) {
    if (isHideStore) {
      return getHideStoreContent();
    } else {
      return getListContent();
    }
  }

  Future setVisibleStore() async {
    bookstoresInScreen.clear();
    LatLngBounds? bounds = await ref
        .read(mapControllerNotiferProvider.notifier)
        .getScreenLatLngBounds();
    filteredBookstroes.forEach((bookstore) {
      if (CommonUtil.coordInRect(
          targetLat: bookstore.latitude!,
          targetLon: bookstore.longitude!,
          minLat: bounds!.southwest.latitude,
          minLon: bounds.southwest.longitude,
          maxLat: bounds.northeast.latitude,
          maxLon: bounds.northeast.longitude)) {
        bookstoresInScreen.add(bookstore);
      }
    });
  }

  void showPanel() async {
    await setVisibleStore();
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        child: SingleChildScrollView(
          child: Column(
            children:
                bookstoresInScreen.map((e) => BookStoreTile(store: e)).toList(),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double slideMaxHeight = MediaQuery.of(context).size.height;
    //
    final mapControllerCon = ref.read(mapControllerNotiferProvider.notifier);
    //
    final searchBarVisibleCon = ref.read(searchBarToggleProvider.notifier);
    //
    final double buttonHeight = ref.watch(mapButtonHeightNotifierProvider);
    final buttonHeightCon = ref.read(mapButtonHeightNotifierProvider.notifier);
    //
    final bool panelVisible = ref.watch(mapPanelVisibleNotifierProvider);
    final panelVisibleCon = ref.read(mapPanelVisibleNotifierProvider.notifier);
    //
    final bool hideStoreVisible = ref.watch(hideStoreToggleProvider);
    //
    Set<Marker> markers = ref.watch(widgetMarkerNotiferProvider);

    final mapController = ref.read(mapControllerNotiferProvider);

    /// bottom sheet에서 제스처에 따라 search bar 활성화 때 호출
    void showSearhBar() {
      searchBarVisibleCon.activate();
    }

    /// bottom sheet에서 제스처에 따라 search bar 비활성화 때 호출
    void hideSearhBar() {
      searchBarVisibleCon.deactivate();
    }

    /// bottom sheet에서 슬라이딩 때 button 높이 조절
    void updateButtonHeight(double height) {
      buttonHeightCon.updateHeight(height);
    }

    /// bottom sheet에서 제스처에 따라 panel 비활성화할 때 호출
    void hidePanel() {
      panelVisibleCon.deactivate();
    }

    return BaseLayout(
        child: Stack(
      children: [
        SlidingUpPanel(
          boxShadow: const [],
          //오픈되면 radius 삭제
          borderRadius: (panelState == CustomPanelState.opend)
              ? null
              : BorderRadius.only(
                  topLeft: Radius.circular(slideBraidus),
                  topRight: Radius.circular(slideBraidus)),
          maxHeight: slideMaxHeight,
          minHeight: panelVisible ? slideMinHeight : 0,
          onPanelOpened: () {
            panelOpend();
          },
          onPanelSlide: (position) {
            if (0.05 < position && position < 0.7) {
              isPanelScrolling();
            } else {
              isNotPanelScrolling();
            }
            //패널이 움직이는 동안 높이 계산하여 변환
            double updateHeight =
                slideMinHeight + position * (slideMaxHeight - slideMinHeight);
            if (panelVisible) {
              updateButtonHeight(updateHeight);
            }
          },
          onPanelClosed: () {
            panelClosed();
          },
          panelBuilder: (sc) {
            //펼친 상태에서 스크롤 방향에 따라 검색 바 출력할지 판단
            sc.addListener(() {
              if (panelState == CustomPanelState.opend) {
                ScrollDirection scrollDirection =
                    sc.position.userScrollDirection;
                if (scrollDirection == ScrollDirection.forward) {
                  showSearhBar();
                } else {
                  hideSearhBar();
                }
              }
            });
            return GestureDetector(
              //close일 때 + panel show 일 때 아래 슬라이딩 감지 후 닫기
              onPanUpdate: (details) {
                if (details.delta.dy > 0 &&
                    panelState == CustomPanelState.closed &&
                    panelVisible &&
                    !panelScrolling) {
                  hidePanel();
                }
              },
              child: Container(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    slideIcon,
                    Expanded(
                      child: SingleChildScrollView(
                        controller: sc,
                        // close일 때는 scroll 감지 안되게
                        physics: (panelState == CustomPanelState.opend)
                            ? null
                            : const NeverScrollableScrollPhysics(),

                        child: getPanelContent(hideStoreVisible),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },

          body: GoogleMap(
              zoomControlsEnabled: false,
              onMapCreated: (controller) {
                mapControllerCon.initController(controller);
              },
              markers: markers,
              initialCameraPosition: initCamera),
        ),

        const Align(
          alignment: Alignment.topCenter,
          child: TopBar(),
        ),

        // buttons, open 상태일 때는 출력안함
        ...(panelState == CustomPanelState.closed || panelScrolling)
            ? [
                Positioned(
                    right: buttonPading,
                    bottom: buttonHeight + buttonSpace + buttonPading,
                    child: ListButton(
                      onTap: () {},
                    )),
                Positioned(
                    right: buttonPading,
                    bottom: buttonHeight + buttonPading,
                    child: GpsButton()),
                Positioned(
                    right: buttonPading,
                    bottom: buttonHeight + 120,
                    child: ElevatedButton(
                      onPressed: () {
                        mapControllerCon.zoomIn();
                      },
                      child: Icon(Icons.add),
                    )),
                Positioned(
                    right: buttonPading,
                    bottom: buttonHeight + 90,
                    child: ElevatedButton(
                      onPressed: () {
                        mapControllerCon.zoomOut();
                      },
                      child: Icon(Icons.minimize),
                    )),
                Positioned(
                    right: buttonPading,
                    bottom: buttonHeight + 200,
                    child: ElevatedButton(
                      onPressed: () {
                        showPanel();
                      },
                      child: Icon(Icons.settings),
                    )),
              ]
            : [const SizedBox()]
      ],
    ));
  }
}
