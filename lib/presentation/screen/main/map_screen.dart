import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../core/widget/base_layout.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {

  @override
  Widget build(BuildContext context) {
    return const BaseLayout(
      child: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(37.541, 126.986),
          zoom: 13,
        ),
      ),
    );
  }
}
