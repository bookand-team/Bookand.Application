import 'package:bookand/domain/model/bookmark/bookmark_collection_delete_request.dart';
import 'package:bookand/domain/model/result_response.dart';

abstract class BookmarkRemoteDataSource {
  Future<ResultResponse> addArticleBookmark(String accessToken, int articleId);

  Future<ResultResponse> deleteBookmark(
    String accessToken,
    BookmarkCollectionDeleteRequest bookmarkCollectionDeleteRequest,
  );
}
