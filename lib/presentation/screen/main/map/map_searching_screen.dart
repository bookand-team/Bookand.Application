// ignore_for_file: use_build_context_synchronously

import 'package:bookand/core/widget/base_layout.dart';
import 'package:bookand/domain/model/bookstore/bookstore_map_model.dart';
import 'package:bookand/gen/assets.gen.dart';
import 'package:bookand/presentation/provider/bookstore_manager.dart';
import 'package:bookand/presentation/screen/main/map/map_searched_screen.dart';
import 'package:bookand/presentation/screen/main/map/searched_components/book_store_searched_tile.dart';
import 'package:bookand/presentation/screen/main/map/searched_components/search_top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//providers
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/const/map.dart';

class MapSearchingScreen extends ConsumerStatefulWidget {
  static String get routeName => 'mapSearchIng';
  const MapSearchingScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<MapSearchingScreen> createState() => _MapSearchingScreenState();
}

class _MapSearchingScreenState extends ConsumerState<MapSearchingScreen> {
  FocusNode focusNode = FocusNode();

  final TextEditingController searchTextCon = TextEditingController();

  final double buttonPading = 15;
  final double buttonSpace = 40;

  // 검색 함수에서 완료한 시간
  DateTime searchedTime = DateTime.now();

  List<BookStoreMapModel> allList = [];
  List<BookStoreMapModel> searchingList = [];
  bool searchEmpty = false;

  @override
  void initState() {
    allList = ref.read(bookStoreManagerProvider);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        systemNavigationBarColor: Colors.black,
        statusBarIconBrightness: Brightness.dark));

    return SafeArea(
      child: BaseLayout(
          backgroundColor: Colors.white,
          onWillPop: () async {
            ref.context.pop();
            return true;
          },
          child: Scaffold(
              backgroundColor: Colors.white,
              body: Column(
                children: [
                  SearchTopBar(
                    onFieldFocus: () {},
                    focusNode: focusNode,
                    controller: searchTextCon,

                    onChanged: (value) async {
                      if (DateTime.now()
                              .difference(searchedTime)
                              .inMilliseconds >
                          STORES_SEARCH_INTERVAL) {
                        setState(() {
                          searchEmpty = false;

                          searchingList = searchStores(value);
                        });

                        searchedTime = DateTime.now();
                      }
                    },
                    // 검색 완료 시
                    onSubmitted: (value) {
                      searchingList = searchStores(value);
                      if (searchingList.isEmpty) {
                        setState(() {
                          searchEmpty = true;
                        });
                      } else {
                        ref.context.pushNamed(MapSearchedScreen.routeName,
                            queryParameters: {"query": value},
                            extra: searchingList);
                      }
                    },
                  ),
                  renderBody()
                ],
              ))),
    );
  }

  Widget renderBody() {
    return searchEmpty ? renderEmptyScreen() : renderSearchingScreen();
  }

  Widget renderSearchingScreen() {
    return Expanded(
      child: Container(
        alignment: Alignment.topCenter,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: searchingList
                .map((e) => BookStoreSearchedTile(
                      model: e,
                      isSeaching: false,
                    ))
                .toList(),
          ),
        ),
      ),
    );
  }

  Widget renderEmptyScreen() {
    return Expanded(
      child: Column(
        children: [
          const SizedBox(
            height: 134,
          ),
          renderEmptyInfo(),
          const Spacer(),
          backWithHideButton(),
          const SizedBox(
            height: 56,
          )
        ],
      ),
    );
  }

  Widget renderEmptyInfo() {
    return SizedBox(
      height: 108,
      child: Column(
        children: [
          SvgPicture.asset(
            Assets.images.icWarning,
            width: 36,
            height: 36,
          ),
          const SizedBox(
            height: 16,
          ),
          const Text(
            '검색 결과가 없어요.',
            style: TextStyle(
              color: Color(0xFF222222),
              fontSize: 18,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w500,
              height: 1.50,
              letterSpacing: -0.36,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          const Text(
            '검색어를 수정하거나 숨은 서점을 추천 받아 보세요!',
            style: TextStyle(
              color: Color(0xFF565656),
              fontSize: 14,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w500,
              height: 1.50,
              letterSpacing: -0.28,
            ),
          )
        ],
      ),
    );
  }

  Widget backWithHideButton() {
    return GestureDetector(
      onTap: () {
        ref.context.pop(SEARCH_WAS_EMPTY);
      },
      child: Container(
        width: 328,
        height: 56,
        alignment: Alignment.center,
        decoration: ShapeDecoration(
          color: const Color(0xFF222222),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: const Text(
          '숨은 서점 추천 받기',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontFamily: 'Pretendard',
            fontWeight: FontWeight.w500,
            height: 1.50,
            letterSpacing: -0.64,
          ),
        ),
      ),
    );
  }

  List<BookStoreMapModel> searchStores(String query) {
    if (query.isEmpty) {
      return [];
    }
    // 이름, 장소명 중에 query가 포함된 걸 리턴
    List<BookStoreMapModel> searched = allList
        .where((element) =>
            (element.name?.contains(query) ?? false) ||
            (element.address?.contains(query) ?? false))
        .toList();
    searched.sort((a, b) => a.userDistance!.compareTo(b.userDistance!));
    return searched;
  }
}
