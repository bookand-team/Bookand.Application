// ignore_for_file: use_build_context_synchronously

import 'package:bookand/core/const/map.dart';
import 'package:bookand/domain/model/bookstore/bookstore_map_model.dart';
import 'package:bookand/gen/assets.gen.dart';
import 'package:bookand/presentation/provider/map/bools/map_bookmark_toggle.dart';
import 'package:bookand/presentation/provider/map/bottomhseet/map_bottomsheet_controller_provider.dart';
import 'package:bookand/presentation/provider/map/map_controller_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
// lib test
import 'package:widget_to_marker/widget_to_marker.dart';

part 'widget_marker_provider.g.dart';

/// widget으로 google map에 marker를 생성하기 위한 프로바이더, state를 watch하고, googlemap에 파라미터로 전달하는 방식으로 구현

@Riverpod(keepAlive: true)
class WidgetMarkerNotifer extends _$WidgetMarkerNotifer {
  @override
  Set<Marker> build() {
    return {};
  }

  bool inited = false;

  bool bookmarked = false;

  // 만들어진 모든 마커(제작에 오래 걸려 가지고 있음)
  final Set<Marker> _allMarker = {};
  Marker? _selectedMarker;
  Marker? _hidestoreMarker;
  final Set<Marker> _bookmakredMarkerSet = {};

  final String _bookmarkedTag = '#marked#';

  final Widget _normalStore = SvgPicture.asset(
    Assets.images.map.bookstoreNormal,
    width: 28,
    height: 28,
  );
  final Widget _bigStore = SvgPicture.asset(
    Assets.images.map.bookstoreBig,
    width: 36,
    height: 36,
  );

  final Widget _hidestore = SvgPicture.asset(Assets.images.map.hidestore);

  final Widget _bookmarkStore = SvgPicture.asset(
    Assets.images.map.bookmarkActive,
    width: 28,
    height: 28,
  );

  final Widget _bookmarkStoreBig = SvgPicture.asset(
    Assets.images.map.bookmarkActive,
    width: 36,
    height: 36,
  );

  Widget _createMarkerText(String data, [bool bigStore = false]) {
    Radius br = const Radius.circular(5);
    TextStyle style =
        TextStyle(color: Colors.black, fontSize: bigStore ? 15 : 13);
    EdgeInsets padding = const EdgeInsets.symmetric(vertical: 3, horizontal: 5);
    Color color = Colors.white.withOpacity(0.5);
    return Container(
      padding: padding,
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.all(br)),
      child: Text(
        data,
        style: style,
      ),
    );
  }

  Widget _createHidestoreBody(String data) {
    return SizedBox(
      height: 70,
      child: Column(
        children: [_hidestore, _createMarkerText(data)],
      ),
    );
  }

  Widget _createBigBody(String data) {
    return SizedBox(
      height: 70,
      child: Column(
        children: [_bigStore, _createMarkerText(data, true)],
      ),
    );
  }

  Widget _createNormalBody(String data) {
    return SizedBox(
      height: 60,
      child: Column(
        children: [_normalStore, _createMarkerText(data)],
      ),
    );
  }

  Widget _createBookmarkedBody(String data) {
    return SizedBox(
      height: 60,
      child: Column(
        children: [_bookmarkStore, _createMarkerText(data)],
      ),
    );
  }

  Widget _createBookmarkedBigBody(String data) {
    return SizedBox(
      height: 70,
      child: Column(
        children: [_bookmarkStoreBig, _createMarkerText(data, true)],
      ),
    );
  }

  Future initMarkers(
      List<BookStoreMapModel> bookstoreList, BuildContext context) async {
    int i = 0;
    bookstoreList.forEach((store) async {
      Marker marker = Marker(
        onTap: () async {
          // 다른 마커 정상화
          setAllNormal();
          // 눌러진 마커 검색

          Iterable<Marker> iter =
              state.where((element) => element.markerId.value == store.name);
          if (iter.isNotEmpty) {
            // 눌러진 마커 확대로 변경
            _selectedMarker = iter.first.copyWith(
                zIndexParam: 1,
                iconParam:
                    await _createBigBody(store.name!).toBitmapDescriptor());
            // rebuild
            state.remove(iter.first);
            state.add(_selectedMarker!);
            state = Set.from(state);

            ref
                .read(mapBottomSheetControllerProvider.notifier)
                .showBookstoreSheet(bookstoreList: [store]);

            // 마커 누르면 마커가 바텀시트에 안가리게 위치 조정해서 이동
            ref.read(mapControllerNotiferProvider)?.animateCamera(
                CameraUpdate.newLatLng(LatLng(
                    _selectedMarker!.position.latitude - 0.015,
                    _selectedMarker!.position.longitude)));
          }
        },
        markerId: MarkerId(store.name!),
        position: LatLng(store.latitude ?? SEOUL_COORD_LAT,
            store.longitude ?? SEOUL_COORD_LON),
        icon: await _createNormalBody(store.name!).toBitmapDescriptor(),
      );
      state.add(marker);
      state = Set.from(state);
      i += 1;
      if (i == bookstoreList.length) {
        _allMarker.addAll(state);
      }
    });
    _fetchBookmarkedStoreMarkers(bookstoreList);

    inited = true;
  }

  void setAllNormal() {
    if (!inited) {
      return;
    }
    if (_selectedMarker != null) {
      Iterable<Marker> iter;
      if (bookmarked) {
        iter = _bookmakredMarkerSet.where((element) =>
            element.markerId.value == _selectedMarker!.markerId.value);
      } else {
        iter = _allMarker.where((element) =>
            element.markerId.value == _selectedMarker!.markerId.value);
      }
      if (iter.isNotEmpty) {
        state.add(iter.first);
      }
      state.remove(_selectedMarker);
      _selectedMarker = null;
    }
    if (_hidestoreMarker != null) {
      Iterable<Marker> iter = _allMarker.where((element) =>
          element.markerId.value == _hidestoreMarker!.markerId.value);
      if (iter.isNotEmpty) {
        state.add(iter.first);
      }
      state.remove(_hidestoreMarker);
      _hidestoreMarker = null;
    }
    state = {...state};
  }

  void setBookstoreMarker(List<BookStoreMapModel> bookstoreList) {
    if (!inited) {
      return;
    }
    List<String> listForShow = bookstoreList.map((e) => e.name!).toList();

    Set<Marker> result = {};
    _allMarker.forEach((element) {
      String name = element.markerId.value;
      if (listForShow.contains(name)) {
        result.add(element);
      }
    });

    bookmarked = false;

    state = result;
  }

  Future setOneHideMarker(BookStoreMapModel model) async {
    if (!inited) {
      return;
    }
    setAllNormal();
    bool bookmarked = ref.read(bookMarkToggleNotifierProvider);
    Iterable<Marker> iter = state.where((element) =>
        element.markerId.value ==
        (bookmarked ? model.name! + _bookmarkedTag : model.name!));
    if (iter.isNotEmpty) {
      _hidestoreMarker = iter.first.copyWith(
          zIndexParam: 1,
          iconParam:
              await _createHidestoreBody(model.name!).toBitmapDescriptor());
      state.add(_hidestoreMarker!);
      state.remove(iter.first);
      state = Set.from(state);
    }
  }

  ///북마크 마커 id는 _bookmarkedTag를 붙임, 모델에 접근해서 바꿀 수는 없으니 중간에 패치 네임을 사용
  Future _fetchBookmarkedStoreMarkers(
      List<BookStoreMapModel> bookstoreList) async {
    List<BookStoreMapModel> fechedList = [];
    //북마크 된 모델 + 모델 이름에 태그 붙임
    for (var element in bookstoreList) {
      if (element.isBookmark == true) {
        fechedList.add(element);
      }
    }

    //fechedList에서 이름+태그 리스트
    Iterable<String> newNames = fechedList.map((e) => e.name! + _bookmarkedTag);

    //이미 저장된 marker들 중에서 이름 취함
    Iterable<String> storedNames =
        List.from(_bookmakredMarkerSet.map((e) => e.markerId.value));

    //새로운 북마크된 서점 마커 추가
    for (BookStoreMapModel store in fechedList) {
      String patchedName = store.name! + _bookmarkedTag;

      if (!storedNames.contains(patchedName)) {
        _bookmakredMarkerSet.add(Marker(
          onTap: () async {
            // 다른 마커 정상화
            setAllNormal();
            // 눌러진 마커 검색
            Iterable<Marker> iter = _bookmakredMarkerSet
                .where((element) => element.markerId.value == patchedName);
            if (iter.isNotEmpty) {
              // 눌러진 마커 확대로 변경
              state.remove(iter.first);
              _selectedMarker = iter.first.copyWith(
                  zIndexParam: 1,
                  iconParam: await _createBookmarkedBigBody(store.name!)
                      .toBitmapDescriptor());
              // rebuild
              state.add(_selectedMarker!);
              state = Set.from(state);

              ref
                  .read(mapBottomSheetControllerProvider.notifier)
                  .showBookstoreSheet(bookstoreList: [store]);

              // 마커 누르면 마커가 바텀시트에 안가리게 위치 조정해서 이동
              ref.read(mapControllerNotiferProvider)?.animateCamera(
                  CameraUpdate.newLatLng(LatLng(
                      _selectedMarker!.position.latitude - 0.015,
                      _selectedMarker!.position.longitude)));
            }
          },
          markerId: MarkerId(patchedName),
          position: LatLng(store.latitude ?? SEOUL_COORD_LAT,
              store.longitude ?? SEOUL_COORD_LON),
          icon: await _createBookmarkedBody(store.name!).toBitmapDescriptor(),
        ));
      }
    }
    // 북마크 해제된 서점 마커 삭제
    storedNames.forEach((storedName) {
      if (!newNames.contains(storedName)) {
        _bookmakredMarkerSet
            .removeWhere((element) => element.markerId.value == storedName);
      }
    });
  }

  ///북마크 마커 생성
  Future setBookmarkedStore(List<BookStoreMapModel> storeList) async {
    if (!inited) {
      return;
    }
    bookmarked = true;
    await _fetchBookmarkedStoreMarkers(storeList);
    state = Set.from(_bookmakredMarkerSet);
  }

  Set<Marker> getSearchedMarker(List<BookStoreMapModel> storeList) {
    List<String> nameList = storeList.map((e) => e.name!).toList();
    return _allMarker
        .where((element) => nameList.contains(element.markerId.value))
        .toSet();
  }
}
