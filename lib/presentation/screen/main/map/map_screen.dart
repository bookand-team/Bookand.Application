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
import 'package:bookand/presentation/provider/map/map_state_proivders.dart';
import 'package:bookand/presentation/provider/map/map_controller_provider.dart';
import 'package:bookand/presentation/provider/map/map_marker_provider.dart';

class MapScreen extends ConsumerWidget {
  const MapScreen({super.key});

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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 패널
    final PanelController panelController = PanelController();
    final double slideMaxHeight =
        MediaQuery.of(context).size.height * slideMaxHeightFactor;

    // providers
    final double buttonHeight = ref.watch(buttonHeightProvider);
    final heightCon = ref.read(buttonHeightProvider.notifier);
    //
    final panelState = ref.read(panelStateProvider);
    final panelStateCon = ref.read(panelStateProvider.notifier);
    //
    final bool showPanel = ref.watch(showPanelProvider);
    final showPanelCon = ref.read(showPanelProvider.notifier);
    //
    final searchBarShowCon = ref.read(searchBarShowProvider.notifier);
    //
    final ListType listType = ref.watch(listTypeProvider);
    //
    final Set<Marker> markers = ref.watch(mapMarkerNotiferProvider);
    // final markerCon = ref.watch(mapMarkerNotiferProvider.notifier);
    //
    final mapControllerCon = ref.read(mapControllerNotiferProvider.notifier);
    //

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
        case ListType.none:
          widget = const SizedBox();
          break;
      }

      return widget;
    }

    return BaseLayout(
        child: Stack(
      children: [
        SlidingUpPanel(
          controller: panelController,
          //리스트 버튼 토글 되면 출력
          renderPanelSheet: showPanel,
          boxShadow: const [],
          //오픈되면 radius 삭제
          borderRadius: (panelState == CustomPanelState.opend)
              ? null
              : BorderRadius.only(
                  topLeft: Radius.circular(slideBraidus),
                  topRight: Radius.circular(slideBraidus)),
          maxHeight: slideMaxHeight,
          minHeight: slideMinHeight,
          onPanelOpened: () {
            panelStateCon.updateState(CustomPanelState.opend);
          },
          onPanelSlide: (position) {
            // panelStateCon.updateState(CustomPanelState.scroll);
            //패널이 움직이는 동안 높이 계산하여 변환
            double updateHeight =
                slideMinHeight + position * (slideMaxHeight - slideMinHeight);
            if (showPanel) heightCon.updateHeight(updateHeight);
          },
          onPanelClosed: () {
            panelStateCon.updateState(CustomPanelState.closed);
          },
          panelBuilder: (sc) {
            //펼친 상태에서 스크롤 방향에 따라 검색 바 출력할지 판단
            sc.addListener(() {
              if (panelState == CustomPanelState.opend) {
                ScrollDirection scrollDirection =
                    sc.position.userScrollDirection;
                if (scrollDirection == ScrollDirection.forward) {
                  searchBarShowCon.show();
                } else {
                  searchBarShowCon.notShow();
                }
              }
            });
            return showPanel
                ? GestureDetector(
                    //close일 때 아래 슬라이드 감지
                    onPanUpdate: (details) {
                      if (details.delta.dy > 0) {
                        showPanelCon.toggle();
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
                              child: getPanelContent(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : const SizedBox();
          },

          // body: myMap.googleMap,
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
                    child: const ListButton()),
                Positioned(
                    right: buttonPading,
                    bottom: buttonHeight + buttonPading,
                    child: const GpsButton()),
              ]
      ],
    ));
  }
}
