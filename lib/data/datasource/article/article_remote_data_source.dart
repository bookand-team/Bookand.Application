import 'package:bookand/domain/model/article/article_detail.dart';

import '../../../domain/model/article/article_model.dart';

abstract class ArticleRemoteDataSource {
  Future<ArticleModel> getArticleList(int page);

  Future<ArticleDetail> getArticleDetail(int id);
}
