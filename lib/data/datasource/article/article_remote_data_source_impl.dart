import 'package:bookand/data/datasource/article/article_remote_data_source.dart';
import 'package:bookand/data/service/article_service.dart';
import 'package:bookand/domain/model/article/article_detail.dart';
import 'package:bookand/domain/model/article/article_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'article_remote_data_source_impl.g.dart';

@riverpod
ArticleRemoteDataSource articleRemoteDataSource(ArticleRemoteDataSourceRef ref) {
  final articleService = ref.read(articleServiceProvider);

  return ArticleRemoteDataSourceImpl(articleService);
}

class ArticleRemoteDataSourceImpl implements ArticleRemoteDataSource {
  final ArticleService service;

  ArticleRemoteDataSourceImpl(this.service);

  @override
  Future<ArticleDetail> getArticleDetail(int id) {
    // TODO: implement getArticleDetail
    throw UnimplementedError();
  }

  @override
  Future<ArticleModel> getArticleList(int page) {
    // TODO: implement getArticleList
    throw UnimplementedError();
  }
}
