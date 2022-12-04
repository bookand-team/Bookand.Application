import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../../provider/bottom_nav_index_provider.dart';
import 'bookmark_page.dart';
import 'home_page.dart';
import 'map_page.dart';
import 'my_page.dart';

class MainTab extends ConsumerWidget {
  static String get routeName => 'main';

  const MainTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 0,
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: IndexedStack(
                index: ref.watch(bottomNavIndexProvider),
                children: const [HomePage(), MapPage(), BookmarkPage(), MyPage()],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(bottom: 24),
              decoration: const BoxDecoration(
                  border: Border(top: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.05), width: 2))),
              child: Theme(
                data: ThemeData(splashColor: Colors.transparent),
                child: BottomNavigationBar(
                  items: [
                    BottomNavigationBarItem(
                      icon: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child:
                            SvgPicture.asset('assets/images/home/ic_24_bottom_home_inactive.svg'),
                      ),
                      label: Intl.message('home'),
                      activeIcon: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: SvgPicture.asset('assets/images/home/ic_24_bottom_home_active.svg'),
                      ),
                    ),
                    BottomNavigationBarItem(
                      icon: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: SvgPicture.asset('assets/images/home/ic_24_bottom_map_inactive.svg'),
                      ),
                      label: Intl.message('map'),
                      activeIcon: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: SvgPicture.asset('assets/images/home/ic_24_bottom_map_active.svg'),
                      ),
                    ),
                    BottomNavigationBarItem(
                      icon: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: SvgPicture.asset(
                            'assets/images/home/ic_24_bottom_bookmark_inactive.svg'),
                      ),
                      label: Intl.message('bookmark'),
                      activeIcon: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child:
                            SvgPicture.asset('assets/images/home/ic_24_bottom_bookmark_active.svg'),
                      ),
                    ),
                    BottomNavigationBarItem(
                      icon: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child:
                            SvgPicture.asset('assets/images/home/ic_24_bottom_mypage_inactive.svg'),
                      ),
                      label: Intl.message('myPage'),
                      activeIcon: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child:
                            SvgPicture.asset('assets/images/home/ic_24_bottom_mypage_active.svg'),
                      ),
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
                    ref.watch(bottomNavIndexProvider.notifier).state = index;
                  },
                  currentIndex: ref.watch(bottomNavIndexProvider),
                  elevation: 0,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
