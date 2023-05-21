import 'package:bookand/domain/model/bookmark/bookmark_model.dart';

import '../../core/const/bookmark_type.dart';

abstract class BookmarkRepository {
  Future<void> addArticleBookmark(int articleId);

  Future<void> addBookstoreBookmark(int bookstoreId);

  Future<void> deleteBookmark(
    BookmarkType bookmarkType,
    List<int> contentIdList,
  );

  Future<List<BookmarkModel>?> getBookmarkList(
      {required BookmarkType type,
      int cursorId = 0,
      int page = 0,
      int size = 10});

  Future<bool?> deleteBookmarkContents(
      {required BookmarkType type, required List<int> idList});
}
