import 'package:chopper/chopper.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../api_helper.dart';

part 'bookmark_service.g.dart';

part 'bookmark_service.chopper.dart';

@riverpod
BookmarkService bookmarkService(BookmarkServiceRef ref) =>
    BookmarkService.create(ApiHelper.client());

@ChopperApi(baseUrl: '/api/v1/bookmarks')
abstract class BookmarkService extends ChopperService {
  static BookmarkService create([ChopperClient? client]) => _$BookmarkService(client);

  @Post(path: '/articles/{articleId}', optionalBody: true)
  Future<Response> addArticleBookmark(
    @Header('Authorization') String accessToken,
    @Path('articleId') int articleId,
  );

  @Post(path: '/bookstores/{bookstoreId}', optionalBody: true)
  Future<Response> addBookstoreBookmark(
    @Header('Authorization') String accessToken,
    @Path('bookstoreId') int bookstoreId,
  );

  @Delete(path: '/collections')
  Future<Response> deleteBookmark(
    @Header('Authorization') String accessToken,
    @Body() Map<String, dynamic> body,
  );
}
