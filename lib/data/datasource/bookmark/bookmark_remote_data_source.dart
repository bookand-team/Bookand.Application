import 'package:bookand/core/const/bookmark_type.dart';
import 'package:bookand/domain/model/bookmark/bookmark_collection_delete_request.dart';
import 'package:bookand/domain/model/bookmark/request/bookmark_folder_name_request.dart';
import 'package:bookand/domain/model/bookmark/request/bookmark_ids_request.dart';
import 'package:bookand/domain/model/bookmark/response/bookmark_contents_response.dart';
import 'package:bookand/domain/model/bookmark/response/bookmark_folder_list_response.dart';
import 'package:bookand/domain/model/bookmark/response/bookmark_id_response.dart';
import 'package:bookand/domain/model/result_response.dart';

abstract interface class BookmarkRemoteDataSource {
  Future<ResultResponse> addArticleBookmark(String accessToken, int articleId);

  Future<ResultResponse> addBookstoreBookmark(
      String accessToken, int bookstoreId);

  Future<ResultResponse> deleteBookmark(
    String accessToken,
    BookmarkCollectionDeleteRequest bookmarkCollectionDeleteRequest,
  );

  //content

  Future<BookmarkContentsReponse> getBookmarkList(
    String accessToken, {
    required BookmarkType type,
    int cursorId,
    int page,
    int size,
  });

  Future<ResultResponse> deleteBookmarkContent(String accessToken,
      {required BookmarkIdsRequest request});

  //fodler

  Future<BookmarkFolderListResponse> getBookmarkFolderList(String accessToken,
      {required BookmarkType type});

  Future<BookmarkIdReponse> addBookmarkFolder(String accessToken,
      {required BookmarkFolderNameRequest request});

  Future<BookmarkContentsReponse> getBookmarkFolderContents(String accessToken,
      {required int folderId,
      required int cursorId,
      required int page,
      required int size});

  Future<BookmarkIdReponse> addBookmarkFolderContents(String accessToken,
      {required int folderId, required BookmarkIdsRequest request});

  Future<BookmarkIdReponse> updateBookmarkFolderName(String accessToken,
      {required int folderId, required BookmarkFolderNameRequest request});

  Future<ResultResponse> deleteBookmarkFolder(String accessToken,
      {required int folderId});

  Future<ResultResponse> deleteBookmarkFolderContents(String accessToken,
      {required int folderId, required BookmarkIdsRequest request});
}
