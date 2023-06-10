import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'bookmark_scroller_provider.g.dart';

/// 북마크 서점 폴더 리스트 가지고 있을 프로바이더
@Riverpod()
class BookmarkScrollControllerNotifier
    extends _$BookmarkScrollControllerNotifier {
  PersistentBottomSheetController? controller;
  @override
  ScrollController build() {
    return ScrollController();
  }
}
