import 'dart:async';

import 'package:bookand/presentation/provider/map_provider.dart';
import 'package:bookand/presentation/screen/main/map/components/book_store_tile.dart';
import 'package:bookand/presentation/screen/main/map/components/gps_button.dart';
import 'package:bookand/presentation/screen/main/map/components/list_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../../../core/widget/base_layout.dart';

import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bookand/presentation/provider/map_state_proivders.dart';
import 'components/top_bar/top_bar.dart';

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

  //slide icon
  final Size slideIconSize = const Size(60, 4);
  final Color slideIconColor = const Color(0xffd9d9d9);
  final EdgeInsets sideIconMargin = const EdgeInsets.all(7);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 패널
    final PanelController panelController = PanelController();
    final double slideMaxHeight =
        MediaQuery.of(context).size.height * slideMaxHeightFactor;

    // providers
    final double buttonHeight = ref.watch(buttonHeightProvider);
    final heightCon = ref.read(buttonHeightProvider.notifier);
    final panelState = ref.read(panelStateProvider);
    final panelStateCon = ref.read(panelStateProvider.notifier);
    final bool listShow = ref.watch(listToggleProvider);
    final listShowCon = ref.read(listToggleProvider.notifier);
    final searchBarShowCon = ref.read(searchBarShowProvider.notifier);

    final myMap = ref.read(myMapProvider);

    Widget getSlideIcon() {
      return Container(
        margin: sideIconMargin,
        width: slideIconSize.width,
        height: slideIconSize.height,
        color: slideIconColor,
      );
    }

    return BaseLayout(
        child: Stack(
      children: [
        SlidingUpPanel(
          controller: panelController,
          //리스트 버튼 토글 되면 출력
          renderPanelSheet: listShow,
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
            if (listShow) heightCon.updateHeight(updateHeight);
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
            return listShow
                ? GestureDetector(
                    //close일 때 아래 슬라이드 감지
                    onPanUpdate: (details) {
                      if (details.delta.dy > 0) {
                        listShowCon.toggle();
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          getSlideIcon(),
                          Expanded(
                            child: SingleChildScrollView(
                              controller: sc,
                              child: Column(
                                children: const [
                                  BookStoreTile(),
                                  BookStoreTile(),
                                  BookStoreTile(),
                                  BookStoreTile(),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : const SizedBox();
          },

          body: myMap.googleMap,
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
