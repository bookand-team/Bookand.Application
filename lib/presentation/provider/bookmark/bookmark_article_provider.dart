import 'package:bookand/domain/model/bookmark/bookmark_model.dart';
import 'package:bookand/domain/usecase/bookmark_usercae.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'bookmark_article_provider.g.dart';

/// 북마크 아티클 리스트 가지고 있을 프로바이더
@Riverpod(keepAlive: true)
class BookmarkArticleNotifier extends _$BookmarkArticleNotifier {
  late BookmarkUsecase bookmarkUsecase;
  bool inited = false;
  @override
  List<BookmarkModel> build() {
    bookmarkUsecase = ref.read(bookmarkUsecaseProvider);
    return [];
  }

  Future<bool> init() async {
    if (!inited) {
      inited = true;
      final list = await bookmarkUsecase.initBookmarkArticleList();
      if (list != null) state = list;
    }
    return inited;
  }

  Future add(BookmarkModel model) async {
    await bookmarkUsecase.addBookmarkArticle(model.bookmarkId!);
    state.add(model);
    state = List.from(state);
  }

  ///모아보기 or 폴더 내부에서 삭제
  Future delete(List<int> bookmarkIdList) async {
    await bookmarkUsecase.deleteBookmarkArticleList(idList: bookmarkIdList);
    bookmarkIdList.forEach((id) {
      state.removeWhere((element) => element.bookmarkId == id);
    });
    state = List.from(state);
  }
}
