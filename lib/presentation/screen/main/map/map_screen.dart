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
    final double height = ref.watch(heightProvider);
    final heightCon = ref.read(heightProvider.notifier);
    final bool list = ref.watch(listToggleProvider);
    final mapCon = ref.read(myMapProvider.notifier);

    final myMap = ref.read(myMapProvider);
    double buttonHeightFix = 0;
    if (!list) {
      // slide panel이 없을 경우
      heightCon.updateHeight(0);
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
            renderPanelSheet: list,
            boxShadow: const [],
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(slideBraidus),
                topRight: Radius.circular(slideBraidus)),
            maxHeight: slideMaxHeight,
            minHeight: slideMinHeight,
            onPanelOpened: () {
              //패널 위로
              heightCon.updateHeight(slideMaxHeight - slideMinHeight);
            },
            onPanelSlide: (position) {
              //패널이 움직이는 동안 높이 계산하여 변환
              double updateHeight =
                  position * (slideMaxHeight - slideMinHeight);
              heightCon.updateHeight(updateHeight);
            },
            onPanelClosed: () {
              //패널 닫힐 경우
              heightCon.updateHeight(0);
            },
            panel: list
                ? Container(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Text('test'),
                        TextButton(
                            onPressed: () {
                              mapCon.moveMap();
                            },
                            child: Text('test'))
                      ],
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
            bottom: height + buttonHeightFix + buttonSpace + buttonPading,
            child: const ListButton()),
        Positioned(
            right: buttonPading,
            bottom: height + buttonHeightFix + buttonPading,
            child: const GpsButton()),
      ],
    ));
  }
}
