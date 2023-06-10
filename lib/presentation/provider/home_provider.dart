import 'package:bookand/data/repository/article_repository_impl.dart';
import 'package:bookand/data/repository/bookmark_repository_impl.dart';
import 'package:bookand/domain/model/bookmark/bookmark_model.dart';
import 'package:bookand/presentation/provider/bookmark/bookmark_article_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/util/logger.dart';
import '../../domain/model/article/article_model.dart';
import '../../domain/usecase/delete_bookmark_use_case.dart';

part 'home_provider.g.dart';

@riverpod
class HomeStateNotifier extends _$HomeStateNotifier {
  bool isLoading = false;
  bool isEnd = false;
  int cursorId = 0;
  int size = 15;

  @override
  List<ArticleContent> build() => [];

  void updateBookmarkState(int index) async {
    final List<ArticleContent> copyState = List.from(state);
    final articleId = copyState[index].id;
    final isBookmark = copyState[index].isBookmark;
    copyState[index].isBookmark = !isBookmark;
    state = copyState;

    if (isBookmark) {
      //북마크 페이지 연동
      ref
          .read(bookmarkArticleNotifierProvider.notifier)
          .deleteOnlyState([articleId]);
      await ref
          .read(deleteBookmarkUseCaseProvider)
          .deleteBookmarkArticleList([articleId]);
    } else {
      //북마크 페이지 연동
      final content = copyState[index];
      ref.read(bookmarkArticleNotifierProvider.notifier).addOnlyState(
          BookmarkModel(
              bookmarkId: content.id,
              image: content.mainImage,
              title: content.title));
      await ref.read(bookmarkRepositoryProvider).addArticleBookmark(articleId);
    }
  }

  void fetchArticleList() async {
    try {
      isLoading = true;
      cursorId = 0;
      final article = await ref
          .read(articleRepositoryProvider)
          .getArticleList(cursorId, size);
      cursorId = article.content.last.id;
      isEnd = article.last;
      state = article.content;
    } catch (e) {
      logger.e('아티클 불러오기 실패', e);
    } finally {
      isLoading = false;
    }
  }

  void fetchNextArticleList() async {
    try {
      if (!isLoading && isEnd) return;

      isLoading = true;
      final article = await ref
          .read(articleRepositoryProvider)
          .getArticleList(cursorId, size);
      isEnd = article.last;
      state = [
        ...state,
        ...article.content,
      ];
    } catch (e) {
      logger.e('아티클 불러오기 실패', e);
    } finally {
      isLoading = false;
    }
  }
}
