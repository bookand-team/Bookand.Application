import '../../../entity/article/article_entity.dart';

abstract class ArticleRemoteDataSource {
  Future<ArticleEntity> getArticleList(int page, int row);

  Future<Article> getArticleDetail(int articleId);
}
