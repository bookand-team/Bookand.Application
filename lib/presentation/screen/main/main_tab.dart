import 'package:bookand/presentation/provider/main_tab_provider.dart';
import 'package:bookand/presentation/screen/test/test_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/app_strings.dart';
import '../../../core/widget/base_layout.dart';
import 'bookmark_screen.dart';
import 'home/home_screen.dart';
import 'map/map_screen.dart';
import 'my/my_screen.dart';

class MainTab extends ConsumerWidget {
  static String get routeName => 'main';

  const MainTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mainTabProvider = ref.watch(mainTabNotifierProvider.notifier);
    final mainTabIndex = ref.watch(mainTabNotifierProvider);

    return BaseLayout(
      appBar: AppBar(
        toolbarHeight: 0,
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        foregroundColor: Colors.white,
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
            border: Border(
                top: BorderSide(
                    color: Color.fromRGBO(0, 0, 0, 0.05), width: 2))),
        child: Theme(
          data: ThemeData(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          child: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                    'assets/images/home/ic_24_bottom_home_inactive.svg'),
                label: AppStrings.home,
                activeIcon: SvgPicture.asset(
                    'assets/images/home/ic_24_bottom_home_active.svg'),
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                    'assets/images/home/ic_24_bottom_map_inactive.svg'),
                label: AppStrings.map,
                activeIcon: SvgPicture.asset(
                    'assets/images/home/ic_24_bottom_map_active.svg'),
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                    'assets/images/home/ic_24_bottom_bookmark_inactive.svg'),
                label: AppStrings.bookmark,
                activeIcon: SvgPicture.asset(
                    'assets/images/home/ic_24_bottom_bookmark_active.svg'),
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                    'assets/images/home/ic_24_bottom_mypage_inactive.svg'),
                label: AppStrings.myPage,
                activeIcon: SvgPicture.asset(
                    'assets/images/home/ic_24_bottom_mypage_active.svg'),
              ),
              BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'test')
            ],
            backgroundColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            unselectedItemColor: const Color(0xFF999999),
            selectedItemColor: Colors.black,
            unselectedFontSize: 8,
            selectedFontSize: 8,
            onTap: mainTabProvider.changeScreen,
            currentIndex: mainTabIndex,
            elevation: 0,
          ),
        ),
      ),
      child: PageView(
        controller: mainTabProvider.pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: mainTabProvider.screens,
      ),
    );
  }
}
