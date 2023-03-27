import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bookand/presentation/provider/map_state_proivders.dart';

class GpsButton extends ConsumerWidget {
  const GpsButton({super.key});
  final double size = 32;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(mapStateProvider);
    final bool gps = state.gps;
    final toggleNoti = ref.read(mapStateProvider.notifier);
    return GestureDetector(
      onTap: () {
        toggleNoti.toggleGps();
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
