import '../model/article/article_detail.dart';
import '../model/article/article_model.dart';

abstract interface class ArticleRepository {
  Future<ArticleModel> getArticleList(int cursorId, int size);

  Future<ArticleDetail> getArticleDetail(int id);
}
