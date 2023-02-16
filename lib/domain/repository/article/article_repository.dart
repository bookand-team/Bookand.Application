import '../../model/article_model.dart';

abstract class ArticleRepository {
  Future<List<ArticleModel>> getArticleList(int page, int row);

  Future<ArticleModel> getArticleDetail(int articleId);
}
