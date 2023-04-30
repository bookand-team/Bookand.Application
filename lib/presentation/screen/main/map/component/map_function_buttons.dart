import 'package:bookand/presentation/provider/map/map_controller_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MapZoomInButton extends ConsumerWidget {
  const MapZoomInButton({Key? key}) : super(key: key);
  final double size = 32;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 패널열렸는지는 show panel 에서
    // 다시 누르면 list type은 List(기본)로
    final con = ref.read(mapControllerNotiferProvider.notifier);

    return GestureDetector(
      onTap: () {
        con.zoomIn();
      },
      child: Container(
        height: size,
        width: size,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(1000))),
        child: Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
    );
  }
}

class MapZoomOutButton extends ConsumerWidget {
  const MapZoomOutButton({Key? key}) : super(key: key);
  final double size = 32;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 패널열렸는지는 show panel 에서
    // 다시 누르면 list type은 List(기본)로
    final con = ref.read(mapControllerNotiferProvider.notifier);

    return GestureDetector(
      onTap: () {
        con.zoomOut();
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
