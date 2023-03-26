import '../../core/const/bookmark_type.dart';

abstract class BookmarkRepository {
  Future<void> addArticleBookmark(int articleId);

  Future<void> addBookstoreBookmark(int bookstoreId);

  Future<void> deleteBookmark(
    BookmarkType bookmarkType,
    List<int> contentIdList,
  );
}
