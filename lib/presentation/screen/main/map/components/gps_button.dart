import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bookand/presentation/provider/map_state_proivders.dart';

class GpsButton extends ConsumerWidget {
  const GpsButton({super.key});
  final double size = 32;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gps = ref.watch(gpsToggleProvider);
    final gpsCon = ref.read(gpsToggleProvider.notifier);
    return GestureDetector(
      onTap: () {
        gpsCon.toggle();
      },
      child: Container(
        height: size,
        width: size,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(1000))),
        child: Icon(
          Icons.gps_not_fixed,
          color: gps ? Colors.amber : Colors.black,
        ),
      ),
    );
  }
}
