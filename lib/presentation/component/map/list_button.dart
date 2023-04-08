import 'package:bookand/presentation/provider/map/map_panel_visible_provider.dart';
import 'package:flutter/material.dart';
//providers
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bookand/presentation/provider/map/map_bools_providers.dart';

class ListButton extends ConsumerWidget {
  const ListButton({super.key});
  final double size = 32;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 패널열렸는지는 show panel 에서
    final selected = ref.watch(mapPanelVisibleNotifierProvider);
    // 다시 누르면 list type은 List(기본)로
    final con = ref.read(mapPanelVisibleNotifierProvider.notifier);

    return GestureDetector(
      onTap: () {
        con.toggle();
      },
      child: Container(
        height: size,
        width: size,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(1000))),
        child: Icon(
          Icons.list,
          color: selected ? Colors.amber : Colors.black,
        ),
      ),
    );
  }
}