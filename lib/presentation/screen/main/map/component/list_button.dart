import 'package:bookand/presentation/provider/map/bottomhseet/map_list_toggle.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/material.dart';
//providers
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ListButton extends ConsumerWidget {
  final void Function() onAcitve;
  final void Function() onDeactive;
  const ListButton(
      {super.key, required this.onAcitve, required this.onDeactive});
  final double size = 32;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 패널열렸는지는 show panel 에서
    final selected = ref.watch(mapListToggleProvider);
    // 다시 누르면 list type은 List(기본)로
    final con = ref.read(mapListToggleProvider.notifier);

    return GestureDetector(
      onTap: () {
        if (selected) {
          con.deactivate();
          onDeactive();
        } else {
          con.activate();
          onAcitve();
        }
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