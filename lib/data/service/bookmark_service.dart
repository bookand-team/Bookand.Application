import 'package:bookand/core/const/bookmark_type.dart';
import 'package:bookand/domain/model/bookmark/request/bookmark_folder_name_request.dart';
import 'package:bookand/domain/model/bookmark/request/bookmark_ids_request.dart';
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
  Future<Response> getBookmarkContentList(
    @Header('Authorization') String accessToken,
    @Query('bookmarkType') BookmarkType type,
    @Query('cursorId') int cursorId,
    @Query('page') int page,
    @Query('size') int size,
  );

  @Delete(path: '/collections')
  Future<Response> deleteBookmarkContent(
    @Header('Authorization') String accessToken,
    @Field('bookmarkRequest') BookmarkIdsRequest bookmarkRequest,
  );

  //fodler

  @Get()
  Future<Response> getBookmarkFolderList(
    @Header('Authorization') String accessToken,
    @Query('bookmarkType') BookmarkType type,
  );

  @Post()
  Future<Response> addBookmarkFolder(
    @Header('Authorization') String accessToken,
    @Field('bookmarkRequest') BookmarkFolderNameRequest bookmarkRequest,
  );

  @Get(path: '/folders/{bookmarkFolderId}')
  Future<Response> getBookmarkFolderContents(
    // @Path('bookmarkFolderId') String folderId,
    @Header('Authorization') String accessToken,
    @Query('bookmarkFolderId ') int folderId,
    @Query('cursorId') int cursorId,
    @Query('page') int page,
    @Query('size') int size,
  );

  @Post(path: '/folders/{bookmarkFolderId}')
  Future<Response> addBookmarkFolderContents(
    // @Path('bookmarkFolderId') String folderId,
    @Header('Authorization') String accessToken,
    @Query('bookmarkFolderId ') int folderId,
    @Query('bookmarkRequest') BookmarkIdsRequest bookmarkRequest,
  );

  @Put(path: '/folders/{bookmarkFolderId}')
  Future<Response> updateBookmarkFolderName(
    // @Path('bookmarkFolderId') String folderId,
    @Header('Authorization') String accessToken,
    @Query('bookmarkFolderId ') int folderId,
    @Query('bookmarkRequest') BookmarkFolderNameRequest bookmarkRequest,
  );

  @Delete(path: '/folders/{bookmarkFolderId}')
  Future<Response> deleteBookmarkFolder(
    // @Path('bookmarkFolderId') String folderId,
    @Header('Authorization') String accessToken,
    @Query('bookmarkFolderId ') int folderId,
  );

  @Delete(path: '/folders/{bookmarkFolderId}/contents')
  Future<Response> deleteBookmarkFolderContents(
    // @Path('bookmarkFolderId') String folderId,
    @Header('Authorization') String accessToken,
    @Query('bookmarkFolderId ') int folderId,
    @Query('bookmarkRequest') BookmarkIdsRequest bookmarkRequest,
  );
}
