import 'package:bookand/domain/model/bookmark/bookmark_folder_model.dart';
import 'package:bookand/domain/model/bookmark/bookmark_model.dart';

import '../../core/const/bookmark_type.dart';

abstract class BookmarkFolderRepository {
  Future<List<BookmarkFolderModel>?> getBookmarkFolderList(BookmarkType type);

  Future<int?> addBookmarkFolder(
      {required BookmarkType type, required String name});

  Future<int?> updateBookmarkFolderName(
      {required int folderId, required newName});

  Future<bool?> deleteBookmarkFolder({required int folderId});

  //with contents
  Future<List<BookmarkModel>?> getBookmarkFolderContents(
      {required int folderId, int cursorId = 0, int page = 0, int size = 10});

  Future<int?> addBookmarkFolderContents(
      {required int folderId,
      required BookmarkType type,
      required List<int> idList});

  Future<bool?> deleteBookmarkFolderContents(
      {required int folderId,
      required BookmarkType type,
      required List<int> idList});
}
