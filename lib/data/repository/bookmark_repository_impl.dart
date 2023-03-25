import 'package:bookand/core/const/bookmark_type.dart';
import 'package:bookand/core/util/utf8_util.dart';
import 'package:bookand/data/datasource/bookmark/bookmark_remote_data_source.dart';
import 'package:bookand/data/datasource/bookmark/bookmark_remote_data_source_impl.dart';
import 'package:bookand/data/datasource/token/token_local_data_source.dart';
import 'package:bookand/domain/model/bookmark/bookmark_collection_delete_request.dart';
import 'package:bookand/domain/model/error_response.dart';
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

  BookmarkRepositoryImpl(this.bookmarkRemoteDataSource, this.tokenLocalDataSource);

  @override
  Future<void> addArticleBookmark(int articleId) async {
    try {
      final accessToken = await tokenLocalDataSource.getAccessToken();
      await bookmarkRemoteDataSource.addArticleBookmark(accessToken, articleId);
    } on Response catch (e) {
      final errorResp = ErrorResponse.fromJson(Utf8Util.utf8JsonDecode(e.bodyString));
      logger.e(errorResp.toJson());
    } catch (e) {
      logger.e('아티클 북마크 추가 실패', e);
    }
  }

  @override
  Future<void> deleteBookmark(BookmarkType bookmarkType, List<int> contentIdList) async {
    try {
      final accessToken = await tokenLocalDataSource.getAccessToken();
      final requestModel = BookmarkCollectionDeleteRequest(bookmarkType, contentIdList);
      await bookmarkRemoteDataSource.deleteBookmark(accessToken, requestModel);
    } on Response catch (e) {
      final errorResp = ErrorResponse.fromJson(Utf8Util.utf8JsonDecode(e.bodyString));
      logger.e(errorResp.toJson());
    } catch (e) {
      logger.e('북마크 삭제 실패', e);
    }
  }
}
