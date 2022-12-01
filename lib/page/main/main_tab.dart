import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainTab extends ConsumerWidget {
  static String get routeName => 'main';

  const MainTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(toolbarHeight: 0),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              children: [

              ],
            )
          ],
        ));
  }
}
