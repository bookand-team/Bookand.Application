// import 'package:bookand/presentation/provider/geolocator_permission_provider.dart';
// import 'package:bookand/presentation/provider/map/widget_marker_provider.dart';
import 'package:bookand/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:bookand/presentation/provider/map/map_marker_provider.dart';

class GpsButton extends StatefulWidget {
  final Future Function() onAcitve;
  final void Function() onDeactive;
  const GpsButton(
      {super.key, required this.onAcitve, required this.onDeactive});
  @override
  State<GpsButton> createState() => _GpsButtonState();
}

class _GpsButtonState extends State<GpsButton> {
  bool selected = false;
  final double size = 32;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        //활성화 시
        if (!selected) {
          try {
            await widget.onAcitve();
            setState(() {
              selected = true;
            });
          } catch (e) {
            setState(() {
              selected = false;
            });
          }
        } else {
          setState(() {
            selected = false;
          });
          widget.onDeactive();
        }
      },
      child: Container(
          height: size,
          width: size,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(1000))),
          child: SvgPicture.asset(
            Assets.images.map.gpsIcon,
            width: 19.76,
            height: 19.76,
            fit: BoxFit.fill,
            colorFilter: ColorFilter.mode(
                selected ? const Color(0xffF86C30) : Colors.black,
                BlendMode.srcIn),
          )
          // Icon(
          //   Icons.gps_not_fixed,
          //   color: selected ? Colors.amber : Colors.black,
          // ),
          ),
    );
  }
}
