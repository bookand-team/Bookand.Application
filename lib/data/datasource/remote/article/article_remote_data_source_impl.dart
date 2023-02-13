import 'dart:async';

import 'package:bookand/data/datasource/remote/article/article_remote_data_source.dart';
import 'package:bookand/data/entity/article/article_entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../api/article_api.dart';

part 'article_remote_data_source_impl.g.dart';

@riverpod
ArticleRemoteDataSource articleRemoteDataSource(ArticleRemoteDataSourceRef ref) {
  final api = ref.read(articleApiProvider);

  return ArticleRemoteDataSourceImpl(api);
}

class ArticleRemoteDataSourceImpl implements ArticleRemoteDataSource {
  final ArticleApi api;

  ArticleRemoteDataSourceImpl(this.api);

  @override
  Future<ArticleEntity> getArticleList(int page, int row) async {
    final completer = Completer<ArticleEntity>();

    try {
      final resp = await api.getArticleList(page, row);
      completer.complete(resp);
    } catch (e) {
      completer.completeError(e);
    }

    return completer.future;
  }

  @override
  Future<Article> getArticleDetail(int articleId) async {
    final completer = Completer<Article>();

    try {
      final resp = await api.getArticleDetail(articleId);
      completer.complete(resp);
    } catch (e) {
      completer.completeError(e);
    }

    return completer.future;
  }
}
