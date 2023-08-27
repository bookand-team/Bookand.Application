// import 'package:bookand/presentation/provider/geolocator_permission_provider.dart';
// import 'package:bookand/presentation/provider/map/widget_marker_provider.dart';
import 'package:bookand/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:bookand/presentation/provider/map/map_marker_provider.dart';

class GpsButton extends StatelessWidget {
  final void Function() onTap;
  final bool selected;
  const GpsButton({super.key, required this.onTap, required this.selected});

  final double size = 32;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
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
