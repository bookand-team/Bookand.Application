// import 'package:bookand/presentation/provider/geolocator_permission_provider.dart';
// import 'package:bookand/presentation/provider/map/widget_marker_provider.dart';
import 'package:flutter/material.dart';
// import 'package:bookand/presentation/provider/map/map_marker_provider.dart';

class GpsButton extends StatefulWidget {
  final void Function() onAcitve;
  final void Function() onDeactive;
  GpsButton({super.key, required this.onAcitve, required this.onDeactive});
  @override
  _GpsButtonState createState() => _GpsButtonState();
}

class _GpsButtonState extends State<GpsButton> {
  bool selected = false;
  final double size = 32;
  @override
  Widget build(BuildContext context) {
    //permission은 굳이 rebuild 필요 없음

    return GestureDetector(
      onTap: () async {
        //활성화 시
        if (!selected) {
          widget.onAcitve();
        } else {
          widget.onDeactive();
        }
      },
      child: Container(
        height: size,
        width: size,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(1000))),
        child: Icon(
          Icons.gps_not_fixed,
          color: selected ? Colors.amber : Colors.black,
        ),
      ),
    );
  }
}
