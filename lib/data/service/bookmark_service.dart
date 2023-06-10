import 'package:chopper/chopper.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../api_helper.dart';

part 'bookmark_service.chopper.dart';
part 'bookmark_service.g.dart';

@riverpod
BookmarkService bookmarkService(BookmarkServiceRef ref) =>
    BookmarkService.create(ApiHelper.client());

@ChopperApi(baseUrl: '/api/v1/bookmarks')
abstract class BookmarkService extends ChopperService {
  static BookmarkService create([ChopperClient? client]) =>
      _$BookmarkService(client);

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

  //content

  @Get(path: '/collections')
  Future<Response> getBookmarkList(
    @Header('Authorization') String accessToken,
    @Query('bookmarkType') String type,
    @Query('cursorId') int cursorId,
    @Query('page') int page,
    @Query('size') int size,
  );

  @Delete(path: '/collections')
  Future<Response> deleteBookmarkContent(
    @Header('Authorization') String accessToken,
    @Body() Map<String, dynamic> body,
  );

  //folder

  @Get()
  Future<Response> getBookmarkFolderList(
    @Header('Authorization') String accessToken,
    @Query('bookmarkType') String type,
  );

  @Post()
  Future<Response> addBookmarkFolder(
    @Header('Authorization') String accessToken,
    @Body() Map<String, dynamic> body,
  );

  @Get(path: '/folders/{bookmarkFolderId}')
  Future<Response> getBookmarkFolderContents(
    @Header('Authorization') String accessToken,
    @Path('bookmarkFolderId') int folderId,
    @Query('bookmarkFolderId ') int folderIdParam,
    @Query('cursorId') int cursorId,
    @Query('page') int page,
    @Query('size') int size,
  );

  @Post(path: '/folders/{bookmarkFolderId}')
  Future<Response> addBookmarkFolderContents(
    @Header('Authorization') String accessToken,
    @Path('bookmarkFolderId') int folderId,
    @Body() Map<String, dynamic> body,
  );

  @Put(path: '/folders/{bookmarkFolderId}')
  Future<Response> updateBookmarkFolderName(
    @Header('Authorization') String accessToken,
    @Path('bookmarkFolderId') int folderId,
    @Body() Map<String, dynamic> body,
  );

  @Delete(path: '/folders/{bookmarkFolderId}')
  Future<Response> deleteBookmarkFolder(
    @Header('Authorization') String accessToken,
    @Path('bookmarkFolderId') int folderId,
  );

  @Delete(path: '/folders/{bookmarkFolderId}/contents')
  Future<Response> deleteBookmarkFolderContents(
    @Header('Authorization') String accessToken,
    @Path('bookmarkFolderId') int folderId,
    @Body() Map<String, dynamic> body,
  );
}
