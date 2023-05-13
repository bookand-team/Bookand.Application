import 'package:bookand/core/const/bookmark_type.dart';
import 'package:bookand/core/util/logger.dart';
import 'package:bookand/core/util/utf8_util.dart';
import 'package:bookand/data/datasource/bookmark/bookmark_remote_data_source_impl.dart';
import 'package:bookand/domain/model/bookmark/bookmark_content_model.dart';
import 'package:bookand/domain/model/bookmark/request/bookmark_ids_request.dart';
import 'package:bookand/domain/model/bookmark/response/bookmark_contents_response.dart';
import 'package:bookand/domain/model/error_response.dart';
import 'package:bookand/domain/model/result_response.dart';
import 'package:bookand/domain/repository/bookmark_content_repository.dart';
import 'package:chopper/chopper.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../datasource/bookmark/bookmark_remote_data_source.dart';
import '../datasource/token/token_local_data_source.dart';
import '../datasource/token/token_local_data_source_impl.dart';

part 'bookmark_content_repository_impl.g.dart';

@riverpod
BookmarkContentRepository bookmarkContentRepository(
    BookmarkContentRepositoryRef ref) {
  final bookmarkRemoteDataSource = ref.read(bookmarkRemoteDataSourceProvider);
  final tokenLocalDataSource = ref.read(tokenLocalDataSourceProvider);
  return BookmarkContentRepositoryImpl(
      bookmarkRemoteDataSource, tokenLocalDataSource);
}

class BookmarkContentRepositoryImpl implements BookmarkContentRepository {
  BookmarkContentRepositoryImpl(
      this.bookmarkRemoteDataSource, this.tokenLocalDataSource);
  final BookmarkRemoteDataSource bookmarkRemoteDataSource;
  final TokenLocalDataSource tokenLocalDataSource;

  @override
  Future<List<BookmarkContentModel>?> getBookmarkContentList(
      {required BookmarkType type,
      int cursorId = 0,
      int page = 0,
      int size = 10}) async {
    try {
      final accessToken = await tokenLocalDataSource.getAccessToken();
      BookmarkContentsReponse reponse =
          await bookmarkRemoteDataSource.getBookmarkContentList(accessToken,
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
      BookmarkIdsRequest request = BookmarkIdsRequest(
        bookmarkType: type,
      );
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
