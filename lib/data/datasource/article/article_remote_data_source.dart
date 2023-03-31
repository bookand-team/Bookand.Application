import 'package:bookand/domain/model/article/article_detail.dart';

import '../../../domain/model/article/article_model.dart';
import '../../../domain/model/base_response.dart';

abstract class ArticleRemoteDataSource {
  Future<BaseResponse<ArticleModel>> getArticleList(String accessToken, int cursorId);

  Future<ArticleDetail> getArticleDetail(String accessToken, int id);
}
