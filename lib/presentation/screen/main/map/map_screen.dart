import 'package:bookand/presentation/provider/map_provider.dart';
import 'package:bookand/presentation/screen/main/map/components/gps_button.dart';
import 'package:bookand/presentation/screen/main/map/components/list_button.dart';
import 'package:flutter/material.dart';

import '../../../../core/widget/base_layout.dart';

import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bookand/presentation/provider/map_state_proivders.dart';
import 'components/top_bar.dart';

class MapScreen extends ConsumerWidget {
  const MapScreen({super.key});

  final double slideMaxHeight = 350;
  final double slideMinHeight = 80;
  //slide panel borderraidus
  final double slideBraidus = 24;
  // 버튼 하단, 오른쪽  패딩
  final double buttonPading = 15;
  //버튼 사이의 간격
  final double buttonSpace = 40;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(mapStateProvider);
    final bool listToggle = state.list;
    final bool gpsToggle = state.gps;
    final double buttonHeight = state.height;
    final stateController = ref.read(mapStateProvider.notifier);
    final myMap = ref.read(myMapProvider);
    double buttonHeightFix = 0;
    if (!listToggle) {
      // slide panel이 없을 경우
      stateController.updateHeight(0);
    } else {
      // slide panel이 있으면
      buttonHeightFix = slideMinHeight;
    }
    return BaseLayout(
        child: Stack(
      children: [
        Align(
          alignment: Alignment.bottomCenter,
          child: SlidingUpPanel(
            //리스트 버튼 토글 되면 출력
            renderPanelSheet: listToggle,
            boxShadow: const [],
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(slideBraidus),
                topRight: Radius.circular(slideBraidus)),
            maxHeight: slideMaxHeight,
            minHeight: slideMinHeight,
            onPanelOpened: () {
              //패널 위로
              stateController.updateHeight(slideMaxHeight - slideMinHeight);
            },
            onPanelSlide: (position) {
              //패널이 움직이는 동안 높이 계산하여 변환
              double updateHeight =
                  position * (slideMaxHeight - slideMinHeight);
              stateController.updateHeight(updateHeight);
            },
            onPanelClosed: () {
              //패널 닫힐 경우
              stateController.updateHeight(0);
            },
            panel: listToggle
                ? Container(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: const [Text('test')],
                    ),
                  )
                : const SizedBox(),

            body: myMap.googleMap,
          ),
        ),
        //top bar
        const Align(
          alignment: Alignment.topCenter,
          child: TopBar(),
        ),
        //buttons
        Positioned(
            right: buttonPading,
            bottom: buttonHeight + buttonHeightFix + buttonSpace + buttonPading,
            child: const ListButton()),
        Positioned(
            right: buttonPading,
            bottom: buttonHeight + buttonHeightFix + buttonPading,
            child: const GpsButton()),
      ],
    ));
  }
}
