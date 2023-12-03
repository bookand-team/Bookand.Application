import 'package:bookand/data/repository/bookstore_repository_impl.dart';
import 'package:bookand/domain/model/bookstore/bookstore_map_model.dart';
import 'package:bookand/presentation/provider/bookstore_manager.dart';
import 'package:collection/collection.dart';
import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/util/logger.dart';
import '../../data/repository/bookmark_repository_impl.dart';
import '../../domain/model/article/article_model.dart';
import '../../domain/model/bookmark/bookmark_model.dart';
import '../../domain/model/bookstore/bookstore_detail.dart';
import '../../domain/model/error_response.dart';
import '../../domain/usecase/delete_bookmark_use_case.dart';
import 'bookmark/bookmark_store_provider.dart';

part 'bookstore_provider.g.dart';

@riverpod
class BookstoreStateNotifier extends _$BookstoreStateNotifier {
  @override
  BookstoreDetail build() => BookstoreDetail();

  void fetchBookstoreDetail(int id) async {
    try {
      state = await ref.read(bookstoreRepositoryProvider).getBookstoreDetail(id);
    } on ErrorResponse catch (e, stack) {
      logger.e('[${e.code}] ${e.message}', e.log, stack);
    } catch (e, stack) {
      logger.e(e.toString(), e, stack);
    }
  }

  void updateBookstoreBookmark() async {
    final isBookmark = state.isBookmark ?? false;

    state = state.copyWith(isBookmark: !isBookmark);

    // TODO 북마크 연동 (리팩토링 중)
    if (isBookmark) {
      // 북마크 해제
      //bookmark 페이지 연동
      ref
          .read(bookmarkStoreNotifierProvider.notifier)
          .deleteOnlyState([state.id ?? -1]);
    } else {
      // 북마크 추가
      //bookmark 페이지 연동
      BookStoreMapModel? selected = ref
          .read(bookStoreManagerProvider)
          .firstWhereOrNull((element) => element.id == state.id);
      if (selected != null) {
        ref.read(bookmarkStoreNotifierProvider.notifier).addOnlyState(
            BookmarkModel(
                bookmarkId: selected.id,
                image: selected.mainImage,
                title: selected.name,
                location: selected.address));
      }
    }
    // TODO 맵 페이지 연동(리팩토링 중)
    ref
        .read(bookStoreManagerProvider.notifier)
        .updateBookmark(state.id ?? -1, !isBookmark);

    if (isBookmark) {
      await ref
          .read(deleteBookmarkUseCaseProvider)
          .deleteBookmarkBookstoreList([state.id ?? -1]);
    } else {
      await ref
          .read(bookmarkRepositoryProvider)
          .addBookstoreBookmark(state.id ?? -1);
    }
  }

  void updateArticleBookmark(int index) async {
    try {
      final List<ArticleContent> articleList =
          List.from(state.articleResponse ?? []);
      final isBookmark = articleList[index].isBookmark;

      articleList[index].isBookmark = !isBookmark;

      state = state.copyWith(articleResponse: articleList);

      if (isBookmark) {
        await ref
            .read(deleteBookmarkUseCaseProvider)
            .deleteBookmarkArticleList([state.id ?? -1]);
      } else {
        await ref
            .read(bookmarkRepositoryProvider)
            .addArticleBookmark(state.id ?? -1);
      }
    } catch (e) {
      logger.e(e);
    }
  }

  void copyAddress() {
    final address = state.info?.address;
    if (address == null) return;

    Clipboard.setData(ClipboardData(text: address));
  }
}
