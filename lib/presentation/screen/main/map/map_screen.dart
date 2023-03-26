import 'package:bookand/presentation/screen/main/map/components/gps_button.dart';
import 'package:bookand/presentation/screen/main/map/components/list_button.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
    final bool listToggle = ref.watch(listToggleProvider);
    final bool gpsToggle = ref.watch(gpsToggleProvider);
    final double buttonHeight = ref.watch(heightProvider);
    final height = ref.read(heightProvider.notifier);
    double buttonHeightFix = 0;
    if (!listToggle) {
      height.updateHeight(0);
    } else {
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
              height.updateHeight(slideMaxHeight - slideMinHeight);
            },
            onPanelSlide: (position) {
              double updateHeight =
                  position * (slideMaxHeight - slideMinHeight);
              height.updateHeight(updateHeight);
            },
            onPanelClosed: () {
              height.updateHeight(0);
            },
            panel: listToggle
                ? Container(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [const Text('test')],
                    ),
                  )
                : const SizedBox(),
            body: const GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(37.541, 126.986),
                zoom: 13,
              ),
            ),
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
