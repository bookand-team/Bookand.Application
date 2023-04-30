import 'package:flutter/cupertino.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../screen/main/bookmark_screen.dart';
import '../screen/main/home/home_screen.dart';
import '../screen/main/map_screen.dart';
import '../screen/main/my/my_screen.dart';

part 'main_tab_provider.g.dart';

@Riverpod(keepAlive: true)
class MainTabNotifier extends _$MainTabNotifier {
  final pageController = PageController(initialPage: 0);
  final screens = [
    const HomeScreen(),
    const MapScreen(),
    const BookmarkScreen(),
    const MyScreen(),
  ];

  @override
  int build() => 0;

  void changeScreen(int index) {
    if (index < 0 || index >= screens.length) return;
    state = index;
    pageController.jumpToPage(index);
  }

  void changeHomeScreen() {
    changeScreen(0);
  }
}
