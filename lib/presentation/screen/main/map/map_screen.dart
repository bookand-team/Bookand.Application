import 'package:bookand/core/widget/slide_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../core/widget/base_layout.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

//components
import '../../../component/map/top_bar/top_bar.dart';
import 'package:bookand/presentation/component/map/book_store_tile.dart';
import 'package:bookand/presentation/component/map/gps_button.dart';
import 'package:bookand/presentation/component/map/list_button.dart';
import 'package:bookand/presentation/component/map/refresh_button.dart';

//providers
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bookand/presentation/provider/map/map_button_height_provider.dart';
import 'package:bookand/presentation/provider/map/map_panel_content_type_provider.dart';
import 'package:bookand/presentation/provider/map/map_panel_visible_provider.dart';
import 'package:bookand/presentation/provider/map/map_bools_providers.dart';
import 'package:bookand/presentation/provider/map/map_controller_provider.dart';
import 'package:bookand/presentation/provider/map/widget_marker_provider.dart';

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
  static const initCamera =
      CameraPosition(target: LatLng(37.5665, 126.9780), zoom: 13);

  //textstyles
  final TextStyle hideTitle = const TextStyle(
      fontSize: 18, fontWeight: FontWeight.w700, color: Color(0xff222222));

  //varibable
  CustomPanelState panelState = CustomPanelState.closed;
  // panel state에서 관리하려고 하면 open -> scrolling으로 갈 때 오류가 나서 분리
  bool panelScrolling = false;

  void updatePanelState(CustomPanelState state) {
    if (panelState != state) {
      setState(() {
        panelState = state;
      });
    }
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
  Widget build(BuildContext context) {
    final double slideMaxHeight = MediaQuery.of(context).size.height;
    //
    final mapControllerCon = ref.read(mapControllerNotiferProvider.notifier);
    //
    final searchBarVisibleCon = ref.read(searchBarShowProvider.notifier);
    //
    final ContentType listType = ref.watch(mapPanelContentTypeNotifierProvider);
    //
    final double buttonHeight = ref.watch(mapButtonHeightNotifierProvider);
    final buttonHeightCon = ref.read(mapButtonHeightNotifierProvider.notifier);
    //
    final bool panelVisible = ref.watch(mapPanelVisibleNotifierProvider);
    final panelVisibleCon = ref.read(mapPanelVisibleNotifierProvider.notifier);
    //
    final bool hideStoreVisible = ref.watch(hideStoreToggleProvider);
    //
    final Set<Marker> markers = ref.watch(widgetMarkerNotiferProvider);

    /// bottom sheet에서 제스처에 따라 search bar 활성화 때 호출
    void showSearhBar() {
      searchBarVisibleCon.show();
    }

    /// bottom sheet에서 제스처에 따라 search bar 비활성화 때 호출
    void hideSearhBar() {
      searchBarVisibleCon.hide();
    }

    /// bottom sheet에서 슬라이딩 때 button 높이 조절
    void updateButtonHeight(double height) {
      buttonHeightCon.updateHeight(height);
    }

    /// bottom sheet에서 제스처에 따라 panel 비활성화할 때 호출
    void hidePanel() {
      panelVisibleCon.hidePanel();
    }

    Widget getHideStoreContent() {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('당신을 위한 보석같은 서점 추천', style: hideTitle),
              const RefreshButton()
            ],
          ),
          const BookStoreTile()
        ],
      );
    }

    Widget getListContent() {
      return Column(children: const [
        BookStoreTile(),
        BookStoreTile(),
        BookStoreTile(),
        BookStoreTile(),
      ]);
    }

    Widget getPanelContent() {
      if (hideStoreVisible) {
        return getHideStoreContent();
      } else {
        return getListContent();
      }
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
              print(updateHeight);
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

                        child: getPanelContent(),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },

          body:
              // GoogleMap(
              //     zoomControlsEnabled: false,
              //     onMapCreated: (controller) =>
              //         mapControllerCon.initController(controller),
              //     markers: markers,
              //     initialCameraPosition: initCamera),
              //test

              GoogleMap(
                  zoomControlsEnabled: false,
                  onMapCreated: (controller) =>
                      mapControllerCon.initController(controller),
                  markers: markers,
                  initialCameraPosition: initCamera),
          //test
          // WidgetMarkerGoogleMap(
          //     zoomControlsEnabled: false,
          //     onMapCreated: (controller) =>
          //         mapControllerCon.initController(controller),
          //     widgetMarkers: widgetMarkers,
          //     // markers: markers,
          //     initialCameraPosition: initCamera),
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
                    child: const ListButton()),
                Positioned(
                    right: buttonPading,
                    bottom: buttonHeight + buttonPading,
                    child: const GpsButton()),
              ]
            : [const SizedBox()]
      ],
    ));
  }
}
