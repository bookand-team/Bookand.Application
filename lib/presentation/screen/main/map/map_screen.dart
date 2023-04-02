import 'dart:async';

import 'package:bookand/core/widget/slide_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../core/widget/base_layout.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

//components
import 'components/top_bar/top_bar.dart';
import 'components/book_store_tile.dart';
import 'components/gps_button.dart';
import 'components/list_button.dart';
import 'components/refresh_button.dart';

//providers
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bookand/presentation/provider/map/map_bools_providers.dart';
import 'package:bookand/presentation/provider/map/map_state_proivders.dart';
import 'package:bookand/presentation/provider/map/map_controller_provider.dart';
import 'package:bookand/presentation/provider/map/map_marker_provider.dart';

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
  final double slideMaxHeightFactor = 1;
  final double slideMinHeightFactor = 0.4;
  final double slideMinHeight = ButtonHeightNotifier.initheight;

  // init camera
  static const initCamera =
      CameraPosition(target: LatLng(37.5665, 126.9780), zoom: 13);

  //textstyles
  final TextStyle hideTitle = const TextStyle(
      fontSize: 18, fontWeight: FontWeight.w700, color: Color(0xff222222));

  //varibable
  CustomPanelState panelState = CustomPanelState.closed;
  bool panelVisible = false;
  double buttonHeight = 0;
  double initHeihgt = 200;
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

  void updateButtonHeight(double height) {
    setState(() {
      buttonHeight = height;
    });
  }

  void button2Panel() {
    setState(() {
      buttonHeight = initHeihgt;
    });
  }

  void button2Bottom() {
    setState(() {
      buttonHeight = 0;
    });
  }

  void showPanel() {
    button2Panel();
    setState(() {
      panelVisible = true;
    });
  }

  void hidePanel() {
    button2Bottom();
    setState(() {
      panelVisible = false;
    });
  }

  void togglePanelVisible() {
    //끌 때
    if (panelVisible) {
      hidePanel();
    }
    //끌 때
    else {
      showPanel();
    }
  }

  @override
  Widget build(BuildContext context) {
    final double slideMaxHeight =
        MediaQuery.of(context).size.height * slideMaxHeightFactor;
    //
    final Set<Marker> markers = ref.watch(mapMarkerNotiferProvider);
    //
    final mapControllerCon = ref.read(mapControllerNotiferProvider.notifier);
    //
    final searchBarVisibleCon = ref.read(searchBarShowProvider.notifier);
    //
    final listType = ref.watch(listTypeProvider);
    //
    // final bool panelVisible = ref.watch(panelVisibleProvider);
    // final panelVisibleCon = ref.read(panelVisibleProvider.notifier);
    //
    // final double buttonHeight = ref.watch(buttonHeightProvider);
    // final buttonHeightCon = ref.read(buttonHeightProvider.notifier);

    void showSearhBar() {
      searchBarVisibleCon.show();
    }

    void hideSearhBar() {
      searchBarVisibleCon.hide();
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
      late Widget widget;

      switch (listType) {
        case ListType.list:
          widget = getListContent();
          break;
        case ListType.showHide:
          widget = getHideStoreContent();
          break;
        case ListType.theme:
          widget = const SizedBox();
          break;
      }

      return widget;
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
            isNotPanelScrolling();
          },
          onPanelSlide: (position) {
            if (0.1 < position && position < 0.85) {
              print('is scrolling');

              print(panelScrolling);
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
            isNotPanelScrolling();
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

          body: GoogleMap(
              onMapCreated: (controller) =>
                  mapControllerCon.initController(controller),
              markers: markers,
              initialCameraPosition: initCamera),
        ),

        const Align(
          alignment: Alignment.topCenter,
          child: TopBar(),
        ),

        // buttons, open 상태일 때는 출력안함
        ...(panelState == CustomPanelState.opend)
            ? [const SizedBox()]
            : [
                Positioned(
                    right: buttonPading,
                    bottom: buttonHeight + buttonSpace + buttonPading,
                    child: ListButton(
                      onTap: () => togglePanelVisible(),
                      selected: panelVisible,
                    )),
                Positioned(
                    right: buttonPading,
                    bottom: buttonHeight + buttonPading,
                    child: const GpsButton()),
              ]
      ],
    ));
  }
}
