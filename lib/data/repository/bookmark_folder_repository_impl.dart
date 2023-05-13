import 'package:bookand/core/const/bookmark_type.dart';
import 'package:bookand/data/datasource/bookmark/bookmark_remote_data_source.dart';
import 'package:bookand/data/datasource/bookmark/bookmark_remote_data_source_impl.dart';
import 'package:bookand/data/datasource/token/token_local_data_source.dart';
import 'package:bookand/domain/model/bookmark/bookmark_content_model.dart';
import 'package:bookand/domain/model/bookmark/bookmark_folder_model.dart';
import 'package:bookand/domain/model/bookmark/request/bookmark_folder_name_request.dart';
import 'package:bookand/domain/model/bookmark/request/bookmark_ids_request.dart';
import 'package:bookand/domain/model/bookmark/response/bookmark_contents_response.dart';
import 'package:bookand/domain/model/bookmark/response/bookmark_folder_list_response.dart';
import 'package:bookand/domain/model/bookmark/response/bookmark_id_response.dart';
import 'package:bookand/domain/model/result_response.dart';
import 'package:bookand/domain/repository/bookmark_folder_repository.dart';
import 'package:chopper/chopper.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/util/logger.dart';
import '../../core/util/utf8_util.dart';
import '../../domain/model/error_response.dart';
import '../datasource/token/token_local_data_source_impl.dart';

part 'bookmark_folder_repository_impl.g.dart';

@riverpod
BookmarkFolderRepository bookmarkFolderRepository(
    BookmarkFolderRepositoryRef ref) {
  final bookmarkRemoteDataSource = ref.read(bookmarkRemoteDataSourceProvider);
  final tokenLocalDataSource = ref.read(tokenLocalDataSourceProvider);

  return BookmarkFolderRepositoryImpl(
      bookmarkRemoteDataSource, tokenLocalDataSource);
}

class BookmarkFolderRepositoryImpl implements BookmarkFolderRepository {
  final BookmarkRemoteDataSource bookmarkRemoteDataSource;
  final TokenLocalDataSource tokenLocalDataSource;

  BookmarkFolderRepositoryImpl(
      this.bookmarkRemoteDataSource, this.tokenLocalDataSource);

  @override
  Future<List<BookmarkContentModel>?> getBookmarkFolderContents(
      {required int folderId,
      int cursorId = 0,
      int page = 0,
      int size = 10}) async {
    try {
      final accessToken = await tokenLocalDataSource.getAccessToken();
      BookmarkContentsReponse reponse =
          await bookmarkRemoteDataSource.getBookmarkFolderContents(accessToken,
              folderId: folderId, cursorId: cursorId, page: page, size: size);
      return reponse.bookmarkInfo?.content;
    } on Response catch (e) {
      final errorResp =
          ErrorResponse.fromJson(Utf8Util.utf8JsonDecode(e.bodyString));
      logger.e(errorResp.toJson());
      return null;
    } catch (e) {
      logger.e('북마크 폴더 컨텐츠 얻기 실패', e);
      return null;
    }
  }

  @override
  Future<List<BookmarkFolderModel>?> getBookmarkFolderList(
      BookmarkType type) async {
    try {
      final accessToken = await tokenLocalDataSource.getAccessToken();
      BookmarkFolderListResponse reponse = await bookmarkRemoteDataSource
          .getBookmarkFolderList(accessToken, type: type);
      return reponse.bookmarkFolderList;
    } on Response catch (e) {
      final errorResp =
          ErrorResponse.fromJson(Utf8Util.utf8JsonDecode(e.bodyString));
      logger.e(errorResp.toJson());
      return null;
    } catch (e) {
      logger.e('북마크 폴더 리스트 얻기 실패', e);
      return null;
    }
  }

  @override
  Future<int?> addBookmarkFolder(
      {required BookmarkType type, required String name}) async {
    try {
      final accessToken = await tokenLocalDataSource.getAccessToken();
      BookmarkFolderNameRequest request =
          BookmarkFolderNameRequest(bookmarkType: type, folderName: name);
      BookmarkIdReponse reponse = await bookmarkRemoteDataSource
          .addBookmarkFolder(accessToken, request: request);
      return reponse.bookmarkId;
    } on Response catch (e) {
      final errorResp =
          ErrorResponse.fromJson(Utf8Util.utf8JsonDecode(e.bodyString));
      logger.e(errorResp.toJson());
      return null;
    } catch (e) {
      logger.e('북마크 폴더 추가 실패', e);
      return null;
    }
  }

  @override
  Future<int?> addBookmarkFolderContents(
      {required int folderId,
      required BookmarkType type,
      required List<int> idList}) async {
    try {
      final accessToken = await tokenLocalDataSource.getAccessToken();
      BookmarkIdsRequest request =
          BookmarkIdsRequest(bookmarkType: type, contentIdList: idList);
      BookmarkIdReponse reponse =
          await bookmarkRemoteDataSource.addBookmarkFolderContents(accessToken,
              folderId: folderId, request: request);
      return reponse.bookmarkId;
    } on Response catch (e) {
      final errorResp =
          ErrorResponse.fromJson(Utf8Util.utf8JsonDecode(e.bodyString));
      logger.e(errorResp.toJson());
      return null;
    } catch (e) {
      logger.e('북마크 폴더 컨텐츠 추가 실패', e);
      return null;
    }
  }

  @override
  Future<int?> updateBookmarkFolderName(
      {required int folderId, required newName}) async {
    try {
      final accessToken = await tokenLocalDataSource.getAccessToken();
      BookmarkFolderNameRequest request = BookmarkFolderNameRequest(
          bookmarkType: BookmarkType.bookstore, folderName: newName);
      BookmarkIdReponse reponse =
          await bookmarkRemoteDataSource.updateBookmarkFolderName(accessToken,
              folderId: folderId, request: request);
      return reponse.bookmarkId;
    } on Response catch (e) {
      final errorResp =
          ErrorResponse.fromJson(Utf8Util.utf8JsonDecode(e.bodyString));
      logger.e(errorResp.toJson());
      return null;
    } catch (e) {
      logger.e('북마크 폴더 이름 수정 실패', e);
      return null;
    }
  }

  @override
  Future<bool?> deleteBookmarkFolder({required int folderId}) async {
    try {
      final accessToken = await tokenLocalDataSource.getAccessToken();
      ResultResponse reponse = await bookmarkRemoteDataSource
          .deleteBookmarkFolder(accessToken, folderId: folderId);
      if (reponse.result == 'true') {
        return true;
      } else if (reponse.result == 'false') {
        return false;
      } else {
        return null;
      }
    } on Response catch (e) {
      final errorResp =
          ErrorResponse.fromJson(Utf8Util.utf8JsonDecode(e.bodyString));
      logger.e(errorResp.toJson());
      return null;
    } catch (e) {
      logger.e('북마크 폴더 삭제 실패', e);
      return null;
    }
  }

  @override
  Future<bool?> deleteBookmarkFolderContents(
      {required int folderId,
      required BookmarkType type,
      required List<int> idList}) async {
    try {
      final accessToken = await tokenLocalDataSource.getAccessToken();
      BookmarkIdsRequest request =
          BookmarkIdsRequest(bookmarkType: type, contentIdList: idList);
      ResultResponse reponse = await bookmarkRemoteDataSource
          .deleteBookmarkFolderContents(accessToken,
              folderId: folderId, request: request);
      if (reponse.result == 'true') {
        return true;
      } else if (reponse.result == 'false') {
        return false;
      } else {
        return null;
      }
    } on Response catch (e) {
      final errorResp =
          ErrorResponse.fromJson(Utf8Util.utf8JsonDecode(e.bodyString));
      logger.e(errorResp.toJson());
      return null;
    } catch (e) {
      logger.e('북마크 폴더 컨텐츠 삭제 실패', e);
      return null;
    }
  }
}
