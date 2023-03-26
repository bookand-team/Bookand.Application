import 'package:bookand/core/util/utf8_util.dart';
import 'package:bookand/data/datasource/bookmark/bookmark_remote_data_source.dart';
import 'package:bookand/data/service/bookmark_service.dart';
import 'package:bookand/domain/model/bookmark/bookmark_collection_delete_request.dart';
import 'package:bookand/domain/model/result_response.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'bookmark_remote_data_source_impl.g.dart';

@riverpod
BookmarkRemoteDataSource bookmarkRemoteDataSource(BookmarkRemoteDataSourceRef ref) {
  final bookmarkService = ref.read(bookmarkServiceProvider);

  return BookmarkRemoteDataSourceImpl(bookmarkService);
}

class BookmarkRemoteDataSourceImpl implements BookmarkRemoteDataSource {
  final BookmarkService service;

  BookmarkRemoteDataSourceImpl(this.service);

  @override
  Future<ResultResponse> addArticleBookmark(String accessToken, int articleId) async {
    final resp = await service.addArticleBookmark(accessToken, articleId);

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
}
