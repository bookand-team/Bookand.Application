import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainTab extends ConsumerWidget {
  static String get routeName => 'main';

  const MainTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(title: const Text('메인 페이지')),
        body: const Center(
          child: Text('메인 페이지'),
        ));
  }
}
