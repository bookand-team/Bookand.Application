import 'package:bookand/core/const/bookmark_type.dart';
import 'package:bookand/domain/model/bookmark/bookmark_content_model.dart';

abstract class BookmarkContentRepository {
  Future<List<BookmarkContentModel>?> getBookmarkContentList(
      {required BookmarkType type,
      int cursorId = 0,
      int page = 0,
      int size = 10});

  Future<bool?> deleteBookmarkContents(
      {required BookmarkType type, required List<int> idList});
}
