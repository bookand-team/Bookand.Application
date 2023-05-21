import 'dart:developer';

import 'package:bookand/core/const/bookmark_type.dart';
import 'package:bookand/domain/model/bookmark/bookmark_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'bookmark_eidt_list.g.dart';

/// 북마크 서점 편집 모드에서 체크한 북마크 리스트 가지고 있을 프로바이더
@Riverpod(keepAlive: true)
class BookmarkEditListNotifier extends _$BookmarkEditListNotifier {
  @override
  List<int> build() {
    return [];
  }

  void toggle(BookmarkType type, BookmarkModel model) {
    log('test lsit = $state');
    if (!state.contains(model.bookmarkId!)) {
      state.add(model.bookmarkId!);
    } else {
      state.remove(model.bookmarkId!);
    }
  }

  void clear() {
    state = [];
  }
}
