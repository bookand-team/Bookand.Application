import 'package:bookand/data/repository/bookstore_repository_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/util/logger.dart';
import '../../data/repository/bookmark_repository_impl.dart';
import '../../domain/model/article/article_model.dart';
import '../../domain/model/bookstore/bookstore_detail.dart';
import '../../domain/usecase/delete_bookmark_use_case.dart';

part 'bookstore_provider.g.dart';

@riverpod
class BookstoreStateNotifier extends _$BookstoreStateNotifier {
  @override
  BookstoreDetail build() => BookstoreDetail();

  void fetchBookstoreDetail(int id) async {
    try {
      state = await ref.read(bookstoreRepositoryProvider).getBookstoreDetail(id);
    } catch (e) {
      logger.e(e);
    }
  }

  void onTapBookstoreShare() {
    // TODO: 공유하기
  }

  void updateBookstoreBookmark() async {
    final isBookmark = state.isBookmark ?? false;

    state = state.copyWith(isBookmark: !isBookmark);

    if (isBookmark) {
      await ref.read(deleteBookmarkUseCaseProvider).deleteBookmarkBookstoreList([state.id ?? -1]);
    } else {
      await ref.read(bookmarkRepositoryProvider).addBookstoreBookmark(state.id ?? -1);
    }
  }

  void updateArticleBookmark(int index) async {
    try {
      final List<ArticleContent> articleList = List.from(state.articleResponse ?? []);
      final isBookmark = articleList[index].isBookmark;

      articleList[index].isBookmark = !isBookmark;

      state = state.copyWith(articleResponse: articleList);

      if (isBookmark) {
        await ref.read(deleteBookmarkUseCaseProvider).deleteBookmarkArticleList([state.id ?? -1]);
      } else {
        await ref.read(bookmarkRepositoryProvider).addArticleBookmark(state.id ?? -1);
      }
    } catch (e) {
      logger.e(e);
    }
  }
}
