import 'package:bookand/presentation/provider/bookmark/main_context_provider.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'bookmark_edit_provider.g.dart';

/// 북마크 서점 폴더 리스트 가지고 있을 프로바이더
@Riverpod()
class BookmarkEditNotifier extends _$BookmarkEditNotifier {
  PersistentBottomSheetController? controller;

  @override
  bool build() {
    return false;
  }

  void toggle() {
    state = !state;
  }

  void editOff() {
    state = false;
  }

  //네비 가리는 바텀 시트 출력
  showEditBottomSheet(BuildContext context, Widget bottomSheet) {
    state = true;
    final key = ref.read(mainContextNotifierProvider);
    if (key.currentContext != null) {
      controller = key.currentState?.showBottomSheet((context) => bottomSheet);
    } else {
      controller = showBottomSheet(
        context: context,
        builder: (context) => bottomSheet,
      );
    }
  }

  closeBottomSheet() {
    controller?.close();
    controller = null;
    state = false;
  }
}
