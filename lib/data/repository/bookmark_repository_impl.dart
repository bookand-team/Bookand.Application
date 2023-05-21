import 'package:bookand/core/const/bookmark_type.dart';
import 'package:bookand/core/util/utf8_util.dart';
import 'package:bookand/data/datasource/bookmark/bookmark_remote_data_source.dart';
import 'package:bookand/data/datasource/bookmark/bookmark_remote_data_source_impl.dart';
import 'package:bookand/data/datasource/token/token_local_data_source.dart';
import 'package:bookand/domain/model/bookmark/bookmark_collection_delete_request.dart';
import 'package:bookand/domain/model/bookmark/bookmark_model.dart';
import 'package:bookand/domain/model/bookmark/request/bookmark_ids_request.dart';
import 'package:bookand/domain/model/bookmark/response/bookmark_contents_response.dart';
import 'package:bookand/domain/model/error_response.dart';
import 'package:bookand/domain/model/result_response.dart';
import 'package:bookand/domain/repository/bookmark_repository.dart';
import 'package:chopper/chopper.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/util/logger.dart';
import '../datasource/token/token_local_data_source_impl.dart';

part 'bookmark_repository_impl.g.dart';

@riverpod
BookmarkRepository bookmarkRepository(BookmarkRepositoryRef ref) {
  final bookmarkRemoteDataSource = ref.read(bookmarkRemoteDataSourceProvider);
  final tokenLocalDataSource = ref.read(tokenLocalDataSourceProvider);

  return BookmarkRepositoryImpl(bookmarkRemoteDataSource, tokenLocalDataSource);
}

class BookmarkRepositoryImpl implements BookmarkRepository {
  final BookmarkRemoteDataSource bookmarkRemoteDataSource;
  final TokenLocalDataSource tokenLocalDataSource;

  BookmarkRepositoryImpl(
      this.bookmarkRemoteDataSource, this.tokenLocalDataSource);

  @override
  Future<void> addArticleBookmark(int articleId) async {
    try {
      final accessToken = await tokenLocalDataSource.getAccessToken();
      await bookmarkRemoteDataSource.addArticleBookmark(accessToken, articleId);
    } on Response catch (e) {
      final errorResp =
          ErrorResponse.fromJson(Utf8Util.utf8JsonDecode(e.bodyString));
      logger.e(errorResp.toJson());
    } catch (e) {
      logger.e('아티클 북마크 추가 실패', e);
    }
  }

  @override
  Future<void> addBookstoreBookmark(int bookstoreId) async {
    try {
      final accessToken = await tokenLocalDataSource.getAccessToken();
      await bookmarkRemoteDataSource.addBookstoreBookmark(
          accessToken, bookstoreId);
    } on Response catch (e) {
      final errorResp =
          ErrorResponse.fromJson(Utf8Util.utf8JsonDecode(e.bodyString));
      logger.e(errorResp.toJson());
    } catch (e) {
      logger.e('서점 북마크 추가 실패', e);
    }
  }

  @override
  Future<void> deleteBookmark(
      BookmarkType bookmarkType, List<int> contentIdList) async {
    try {
      final accessToken = await tokenLocalDataSource.getAccessToken();
      final requestModel =
          BookmarkCollectionDeleteRequest(bookmarkType, contentIdList);
      await bookmarkRemoteDataSource.deleteBookmark(accessToken, requestModel);
    } on Response catch (e) {
      final errorResp =
          ErrorResponse.fromJson(Utf8Util.utf8JsonDecode(e.bodyString));
      logger.e(errorResp.toJson());
    } catch (e) {
      logger.e('북마크 삭제 실패', e);
    }
  }

  @override
  Future<List<BookmarkModel>?> getBookmarkList(
      {required BookmarkType type,
      int cursorId = 0,
      int page = 0,
      int size = 10}) async {
    try {
      final accessToken = await tokenLocalDataSource.getAccessToken();
      BookmarkContentsReponse reponse =
          await bookmarkRemoteDataSource.getBookmarkList(accessToken,
              type: type, cursorId: cursorId, page: page, size: size);
      return reponse.bookmarkInfo?.content;
    } on Response catch (e) {
      final errorResp =
          ErrorResponse.fromJson(Utf8Util.utf8JsonDecode(e.bodyString));
      logger.e(errorResp.toJson());
      return null;
    } catch (e) {
      logger.e('북마크 컨텐츠 얻기 실패', e);
      return null;
    }
  }

  @override
  Future<bool?> deleteBookmarkContents(
      {required BookmarkType type, required List<int> idList}) async {
    try {
      final accessToken = await tokenLocalDataSource.getAccessToken();
      BookmarkIdsRequest request =
          BookmarkIdsRequest(bookmarkType: type, contentIdList: idList);
      ResultResponse reponse = await bookmarkRemoteDataSource
          .deleteBookmarkContent(accessToken, request: request);
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
      logger.e('북마크 컨텐츠 삭제 실패', e);
      return null;
    }
  }
}
