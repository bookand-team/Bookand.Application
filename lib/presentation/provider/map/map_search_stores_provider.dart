import 'dart:async';

import 'package:bookand/core/util/logger.dart';
import 'package:bookand/domain/model/bookstore/bookstore_map_model.dart';
import 'package:bookand/presentation/provider/map/map_bookstores_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'map_search_stores_provider.g.dart';

//map에 출력할 boostoremodel 관리 프로바이더
@Riverpod(keepAlive: true)
class MapSearchStoreNotifier extends _$MapSearchStoreNotifier
    with ChangeNotifier {
  @override
  List<BookStoreMapModel> build() => <BookStoreMapModel>[];

  //간 계산 값
  Duration? duration;
  //첫 텍스트
  DateTime? textIn;
  //다음 텍스트
  DateTime? nextText;

  Timer? timer;
  void _searchStores(String data) {
    List<BookStoreMapModel> all = ref.read(mapBookStoreNotifierProvider);
    //검색어 포함한 store 거리 순으로 정렬해서 리턴
    List<BookStoreMapModel> searched =
        all.where((element) => element.name!.contains(data)).toList();
    searched.sort((a, b) => a.userDistance!.compareTo(b.userDistance!));
    state = searched;
    logger.d('return all = $all , searched = $state');
  }

//마지막 입력 후 500ms가 지나면 검색결과 리턴
  void searchTextChange(String data) {
    if (timer == null) {
      //500ms 마다 실행
      timer = Timer(Duration(milliseconds: 500), () {
        _searchStores(data);
        timer?.cancel();
        timer = null;
        logger.d('test');
      });
    } else {}

    //처음 적을 때
    // if (textIn == null) {
    //   textIn ??= DateTime.now();
    //   return;
    // } else {
    //   //두번 째 부터 간격 검사
    //   nextText = DateTime.now();
    //   duration = nextText!.difference(textIn!);
    //   textIn = DateTime.now();
    //   //간격이 500ms이상일 경우
    //   if (duration!.inMilliseconds >= 500) {
    //     return;
    //   } else {
    //     //500ms보다 짧을 경우
    //     return;
    //   }
    // }
  }
}
