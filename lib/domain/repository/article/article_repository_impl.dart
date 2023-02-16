import 'package:bookand/data/datasource/remote/article/article_remote_data_source_impl.dart';
import 'package:bookand/domain/repository/article/article_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../data/datasource/remote/article/article_remote_data_source.dart';
import '../../model/article_model.dart';

part 'article_repository_impl.g.dart';

@riverpod
ArticleRepository articleRepository(ArticleRepositoryRef ref) {
  final articleRemoteDataSource = ref.read(articleRemoteDataSourceProvider);

  return ArticleRepositoryImpl(articleRemoteDataSource);
}

class ArticleRepositoryImpl implements ArticleRepository {
  final ArticleRemoteDataSource articleRemoteDataSource;

  ArticleRepositoryImpl(this.articleRemoteDataSource);

  @override
  Future<List<ArticleModel>> getArticleList(int page, int row) async {
    final articleEntity = await articleRemoteDataSource.getArticleList(page, row);

    return [ArticleModel()];
  }

  @override
  Future<ArticleModel> getArticleDetail(int articleId) async {
    final article = await articleRemoteDataSource.getArticleDetail(articleId);

    return ArticleModel();
  }
}
