import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/app_strings.dart';
import '../../../core/widget/base_layout.dart';
import 'bookmark_screen.dart';
import 'home_screen.dart';
import 'map/map_screen.dart';
import 'my/my_screen.dart';

class MainTab extends StatefulWidget {
  static String get routeName => 'main';

  const MainTab({super.key});

  @override
  State<MainTab> createState() => _MainTabState();
}

class _MainTabState extends State<MainTab> with SingleTickerProviderStateMixin {
  late final tabController = TabController(length: screens.length, vsync: this);
  final screens = [
    const HomeScreen(),
    const MapScreen(),
    const BookmarkScreen(),
    const MyScreen(),
  ];

  int currentScreenIdx = 0;

  @override
  void initState() {
    super.initState();
    tabController.addListener(() {
      currentScreenIdx = tabController.index;
    });
  }

  @override
  Widget build(BuildContext context) {
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
            ],
            backgroundColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            unselectedItemColor: const Color(0xFF999999),
            selectedItemColor: Colors.black,
            unselectedFontSize: 8,
            selectedFontSize: 8,
            onTap: (index) {
              setState(() {
                currentScreenIdx = index;
              });
              tabController.index = currentScreenIdx;
            },
            currentIndex: currentScreenIdx,
            elevation: 0,
          ),
        ),
      ),
      child: TabBarView(
        controller: tabController,
        physics: const NeverScrollableScrollPhysics(),
        children: screens,
      ),
    );
  }
}
