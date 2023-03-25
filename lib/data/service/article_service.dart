import 'package:bookand/data/api_helper.dart';
import 'package:chopper/chopper.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'article_service.g.dart';

part 'article_service.chopper.dart';

@riverpod
ArticleService articleService(ArticleServiceRef ref) => ArticleService.create(ApiHelper.client());

@ChopperApi(baseUrl: '/api/v1/articles')
abstract class ArticleService extends ChopperService {
  static ArticleService create([ChopperClient? client]) => _$ArticleService(client);

  @Get()
  Future<Response> getArticleList(
    @Header('Authorization') String accessToken,
    @Query('page') int page,
  );

  @Get(path: '/{id}')
  Future<Response> getArticleDetail(
    @Header('Authorization') String accessToken,
    @Path('id') int id,
  );
}
