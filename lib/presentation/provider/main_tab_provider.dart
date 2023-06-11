import 'package:bookand/presentation/screen/main/bookmark/bookmark_screen.dart';
import 'package:bookand/presentation/screen/main/map/map_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../screen/main/home/home_screen.dart';
import '../screen/main/my/my_screen.dart';

part 'main_tab_provider.g.dart';

@riverpod
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
