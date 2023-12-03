import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapZoomInButton extends StatelessWidget {
  final GoogleMapController? controller;
  const MapZoomInButton({Key? key, required this.controller}) : super(key: key);
  final double size = 32;

  @override
  Widget build(BuildContext context) {
    // 패널열렸는지는 show panel 에서
    // 다시 누르면 list type은 List(기본)로

    return GestureDetector(
      onTap: () {
        controller?.animateCamera(CameraUpdate.zoomIn());
      },
      child: Container(
        height: size,
        width: size,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(1000))),
        child: const Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
    );
  }
}

class MapZoomOutButton extends StatelessWidget {
  final GoogleMapController? controller;
  const MapZoomOutButton({Key? key, required this.controller})
      : super(key: key);
  final double size = 32;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        controller?.animateCamera(CameraUpdate.zoomOut());
      },
      child: Container(
        height: size,
        width: size,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(1000))),
        child: Center(
          child: Container(
            width: 15,
            height: 2,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
