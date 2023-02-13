import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/config/app_config.dart';
import '../api_helper.dart';
import '../entity/article/article_entity.dart';

part 'article_api.g.dart';

@riverpod
ArticleApi articleApi(ArticleApiRef ref) =>
    ArticleApi(ApiHelper.create(), baseUrl: AppConfig.instance.baseUrl);

@RestApi()
abstract class ArticleApi {
  factory ArticleApi(Dio dio, {String baseUrl}) = _ArticleApi;

  @GET('/api/v1/article')
  Future<ArticleEntity> getArticleList(@Query('page') int page, @Query('row') int row);

  @GET('/api/v1/article/{articleId}')
  Future<Article> getArticleDetail(@Path('articleId') int articleId);
}
