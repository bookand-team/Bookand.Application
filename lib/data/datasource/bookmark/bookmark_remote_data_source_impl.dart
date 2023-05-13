import 'package:bookand/core/const/bookmark_type.dart';
import 'package:bookand/core/util/utf8_util.dart';
import 'package:bookand/data/datasource/bookmark/bookmark_remote_data_source.dart';
import 'package:bookand/data/service/bookmark_service.dart';
import 'package:bookand/domain/model/bookmark/bookmark_collection_delete_request.dart';
import 'package:bookand/domain/model/bookmark/request/bookmark_folder_name_request.dart';
import 'package:bookand/domain/model/bookmark/request/bookmark_ids_request.dart';
import 'package:bookand/domain/model/bookmark/response/bookmark_contents_response.dart';
import 'package:bookand/domain/model/bookmark/response/bookmark_folder_list_response.dart';
import 'package:bookand/domain/model/bookmark/response/bookmark_id_response.dart';
import 'package:bookand/domain/model/result_response.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'bookmark_remote_data_source_impl.g.dart';

@riverpod
BookmarkRemoteDataSource bookmarkRemoteDataSource(
    BookmarkRemoteDataSourceRef ref) {
  final bookmarkService = ref.read(bookmarkServiceProvider);

  return BookmarkRemoteDataSourceImpl(bookmarkService);
}

class BookmarkRemoteDataSourceImpl implements BookmarkRemoteDataSource {
  final BookmarkService service;

  BookmarkRemoteDataSourceImpl(this.service);

  @override
  Future<ResultResponse> addArticleBookmark(
      String accessToken, int articleId) async {
    final resp = await service.addArticleBookmark(accessToken, articleId);

    if (resp.isSuccessful) {
      return ResultResponse.fromJson(Utf8Util.utf8JsonDecode(resp.bodyString));
    } else {
      throw resp;
    }
  }

  @override
  Future<ResultResponse> addBookstoreBookmark(
      String accessToken, int bookstoreId) async {
    final resp = await service.addBookstoreBookmark(accessToken, bookstoreId);

    if (resp.isSuccessful) {
      return ResultResponse.fromJson(Utf8Util.utf8JsonDecode(resp.bodyString));
    } else {
      throw resp;
    }
  }

  @override
  Future<ResultResponse> deleteBookmark(
    String accessToken,
    BookmarkCollectionDeleteRequest bookmarkCollectionDeleteRequest,
  ) async {
    final resp = await service.deleteBookmark(
      accessToken,
      bookmarkCollectionDeleteRequest.toJson(),
    );

    if (resp.isSuccessful) {
      return ResultResponse.fromJson(Utf8Util.utf8JsonDecode(resp.bodyString));
    } else {
      throw resp;
    }
  }

  //fodler

  //contents

  @override
  Future<BookmarkContentsReponse> getBookmarkContentList(String accessToken,
      {required BookmarkType type,
      int cursorId = 0,
      int page = 0,
      int size = 10}) async {
    final resp = await service.getBookmarkContentList(
        accessToken, type, cursorId, page, size);

    if (resp.isSuccessful) {
      return BookmarkContentsReponse.fromJson(
          Utf8Util.utf8JsonDecode(resp.bodyString));
    } else {
      throw resp;
    }
  }

  @override
  Future<ResultResponse> deleteBookmarkContent(String accessToken,
      {required BookmarkIdsRequest request}) async {
    final resp = await service.deleteBookmarkContent(accessToken, request);
    if (resp.isSuccessful) {
      return ResultResponse.fromJson(Utf8Util.utf8JsonDecode(resp.bodyString));
    } else {
      throw resp;
    }
  }

  //folders

  @override
  Future<BookmarkFolderListResponse> getBookmarkFolderList(String accessToken,
      {required BookmarkType type}) async {
    final resp = await service.getBookmarkFolderList(accessToken, type);
    if (resp.isSuccessful) {
      return BookmarkFolderListResponse.fromJson(
          Utf8Util.utf8JsonDecode(resp.bodyString));
    } else {
      throw resp;
    }
  }

  @override
  Future<BookmarkContentsReponse> getBookmarkFolderContents(String accessToken,
      {required int folderId,
      required int cursorId,
      required int page,
      required int size}) async {
    final resp = await service.getBookmarkFolderContents(
        accessToken, folderId, cursorId, page, size);
    if (resp.isSuccessful) {
      return BookmarkContentsReponse.fromJson(
          Utf8Util.utf8JsonDecode(resp.bodyString));
    } else {
      throw resp;
    }
  }

  @override
  Future<BookmarkIdReponse> addBookmarkFolder(String accessToken,
      {required BookmarkFolderNameRequest request}) async {
    final resp = await service.addBookmarkFolder(accessToken, request);
    if (resp.isSuccessful) {
      return BookmarkIdReponse.fromJson(
          Utf8Util.utf8JsonDecode(resp.bodyString));
    } else {
      throw resp;
    }
  }

  @override
  Future<BookmarkIdReponse> addBookmarkFolderContents(String accessToken,
      {required folderId, required BookmarkIdsRequest request}) async {
    final resp =
        await service.addBookmarkFolderContents(accessToken, folderId, request);
    if (resp.isSuccessful) {
      return BookmarkIdReponse.fromJson(
          Utf8Util.utf8JsonDecode(resp.bodyString));
    } else {
      throw resp;
    }
  }

  @override
  Future<BookmarkIdReponse> updateBookmarkFolderName(String accessToken,
      {required int folderId,
      required BookmarkFolderNameRequest request}) async {
    final resp =
        await service.updateBookmarkFolderName(accessToken, folderId, request);
    if (resp.isSuccessful) {
      return BookmarkIdReponse.fromJson(
          Utf8Util.utf8JsonDecode(resp.bodyString));
    } else {
      throw resp;
    }
  }

  @override
  Future<ResultResponse> deleteBookmarkFolder(String accessToken,
      {required int folderId}) async {
    final resp = await service.deleteBookmarkFolder(accessToken, folderId);
    if (resp.isSuccessful) {
      return ResultResponse.fromJson(Utf8Util.utf8JsonDecode(resp.bodyString));
    } else {
      throw resp;
    }
  }

  @override
  Future<ResultResponse> deleteBookmarkFolderContents(String accessToken,
      {required int folderId, required BookmarkIdsRequest request}) async {
    final resp = await service.deleteBookmarkFolderContents(
        accessToken, folderId, request);
    if (resp.isSuccessful) {
      return ResultResponse.fromJson(Utf8Util.utf8JsonDecode(resp.bodyString));
    } else {
      throw resp;
    }
  }
}
