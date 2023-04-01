import 'package:bookand/data/repository/article_repository_impl.dart';
import 'package:bookand/domain/model/bookstore/bookstore_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/util/logger.dart';
import '../../data/repository/bookmark_repository_impl.dart';
import '../../domain/model/article/article_detail.dart';
import '../../domain/usecase/delete_bookmark_use_case.dart';

part 'article_provider.g.dart';

@riverpod
class ArticleStateNotifier extends _$ArticleStateNotifier {
  @override
  ArticleDetail build() => ArticleDetail();

  void fetchArticleDetail(int id) async {
    try {
      state = await ref.read(articleRepositoryProvider).getArticleDetail(id);
    } catch (e) {
      logger.e(e);
    }
  }

  void updateArticleBookmark() async {
    final isBookmark = state.bookmark ?? false;

    state = state.copyWith(bookmark: !isBookmark);

    if (isBookmark) {
      await ref.read(deleteBookmarkUseCaseProvider).deleteBookmarkArticleList([state.id ?? -1]);
    } else {
      await ref.read(bookmarkRepositoryProvider).addArticleBookmark(state.id ?? -1);
    }
  }

  void updateBookstoreBookmark(int index) async {
    try {
      final List<BookstoreContent> bookstoreList = List.from(state.bookstoreList ?? []);
      final isBookmark = bookstoreList[index].isBookmark;

      bookstoreList[index].isBookmark = !isBookmark;

      state = state.copyWith(bookstoreList: bookstoreList);

      if (isBookmark) {
        await ref.read(deleteBookmarkUseCaseProvider).deleteBookmarkBookstoreList([state.id ?? -1]);
      } else {
        await ref.read(bookmarkRepositoryProvider).addBookstoreBookmark(state.id ?? -1);
      }
    } catch (e) {
      logger.e(e);
    }
  }
}
