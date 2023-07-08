import 'package:bookand/presentation/provider/bookmark/main_context_provider.dart';
import 'package:bookand/presentation/provider/bookmark/main_ref_provider.dart';
import 'package:bookand/presentation/provider/main_tab_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/app_strings.dart';
import '../../../core/widget/base_layout.dart';

class MainTab extends ConsumerWidget {
  static String get routeName => 'main';

  const MainTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mainTabProvider = ref.watch(mainTabNotifierProvider.notifier);
    final mainTabIndex = ref.watch(mainTabNotifierProvider);
    const bottomNavIconPadding = EdgeInsets.only(bottom: 4);

    Future.delayed(
      const Duration(milliseconds: 500),
      () {
        ref.read(mainRefNotifierProvider.notifier).init(ref);
      },
    );

    return Scaffold(
      key: ref.read(mainContextNotifierProvider),
      body: BaseLayout(
        appBar: AppBar(
          toolbarHeight: 0,
          surfaceTintColor: Colors.white,
          backgroundColor: Colors.white,
          foregroundColor: Colors.white,
        ),
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.05), width: 2))),
          child: Theme(
            data: ThemeData(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
            child: BottomNavigationBar(
              items: [
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: bottomNavIconPadding,
                    child: SvgPicture.asset('assets/images/home/ic_24_bottom_home_inactive.svg'),
                  ),
                  label: AppStrings.home,
                  activeIcon: Padding(
                    padding: bottomNavIconPadding,
                    child: SvgPicture.asset('assets/images/home/ic_24_bottom_home_active.svg'),
                  ),
                ),
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: bottomNavIconPadding,
                    child: SvgPicture.asset('assets/images/home/ic_24_bottom_map_inactive.svg'),
                  ),
                  label: AppStrings.map,
                  activeIcon: Padding(
                    padding: bottomNavIconPadding,
                    child: SvgPicture.asset('assets/images/home/ic_24_bottom_map_active.svg'),
                  ),
                ),
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: bottomNavIconPadding,
                    child:
                        SvgPicture.asset('assets/images/home/ic_24_bottom_bookmark_inactive.svg'),
                  ),
                  label: AppStrings.bookmark,
                  activeIcon: Padding(
                    padding: bottomNavIconPadding,
                    child: SvgPicture.asset('assets/images/home/ic_24_bottom_bookmark_active.svg'),
                  ),
                ),
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: bottomNavIconPadding,
                    child: SvgPicture.asset('assets/images/home/ic_24_bottom_mypage_inactive.svg'),
                  ),
                  label: AppStrings.myPage,
                  activeIcon: Padding(
                    padding: bottomNavIconPadding,
                    child: SvgPicture.asset('assets/images/home/ic_24_bottom_mypage_active.svg'),
                  ),
                ),
              ],
              backgroundColor: Colors.white,
              type: BottomNavigationBarType.fixed,
              showSelectedLabels: true,
              showUnselectedLabels: true,
              unselectedItemColor: const Color(0xFF999999),
              selectedItemColor: Colors.black,
              unselectedFontSize: 10,
              selectedFontSize: 10,
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
      ),
    );
  }
}
