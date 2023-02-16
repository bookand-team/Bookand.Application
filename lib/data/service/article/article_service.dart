import 'package:chopper/chopper.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../api_helper.dart';

part 'article_service.g.dart';

part 'article_service.chopper.dart';

@riverpod
ArticleService articleService(ArticleServiceRef ref) => ArticleService.create(ApiHelper.client());

@ChopperApi(baseUrl: '/api/v1/article')
abstract class ArticleService extends ChopperService {
  static ArticleService create([ChopperClient? client]) => _$ArticleService(client);

  @Get()
  Future<Response> getArticleList(
    @Query('page') int page,
    @Query('row') int row,
  );

  @Get(path: '/{articleId}')
  Future<Response> getArticleDetail(@Path('articleId') int articleId);
}
