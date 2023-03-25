import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../core/widget/base_layout.dart';

import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bookand/presentation/provider/map_state_proivders.dart';

class MapScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listToggle = ref.watch(listToggleProvider);
    final gpsToggle = ref.watch(gpsToggleProvider);
    return BaseLayout(
      child: SlidingUpPanel(
        panel: listToggle ? SizedBox() : SizedBox(),
        body: const GoogleMap(
          initialCameraPosition: CameraPosition(
            target: LatLng(37.541, 126.986),
            zoom: 13,
          ),
        ),
      ),
    );
  }
}
