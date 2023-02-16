import 'dart:async';
import 'dart:convert';

import 'package:bookand/data/datasource/remote/article/article_remote_data_source.dart';
import 'package:bookand/data/entity/article/article_entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../service/article/article_service.dart';

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
  Future<ArticleEntity> getArticleList(int page, int row) async {
    final resp = await service.getArticleList(page, row);
    final data = ArticleEntity.fromJson(jsonDecode(resp.bodyString));

    if (resp.isSuccessful) {
      return data;
    } else {
      throw resp;
    }
  }

  @override
  Future<Article> getArticleDetail(int articleId) async {
    final resp = await service.getArticleDetail(articleId);
    final data = Article.fromJson(jsonDecode(resp.bodyString));

    if (resp.isSuccessful) {
      return data;
    } else {
      throw resp;
    }
  }
}
