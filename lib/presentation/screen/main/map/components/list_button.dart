import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bookand/presentation/provider/map_state_proivders.dart';

class ListButton extends ConsumerWidget {
  const ListButton({super.key});
  final double size = 32;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(mapStateProvider);
    final toggleNoti = ref.read(mapStateProvider.notifier);
    final list = state.list;
    return GestureDetector(
      onTap: () {
        toggleNoti.toggleList();
      },
      child: Container(
        height: size,
        width: size,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(1000))),
        child: Icon(
          Icons.list,
          color: list ? Colors.amber : Colors.black,
        ),
      ),
    );
  }
}
