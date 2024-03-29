import 'package:bookand/core/util/utf8_util.dart';
import 'package:bookand/data/datasource/article/article_remote_data_source.dart';
import 'package:bookand/data/service/article_service.dart';
import 'package:bookand/domain/model/article/article_detail.dart';
import 'package:bookand/domain/model/article/article_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../domain/model/base_response.dart';

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
  Future<ArticleDetail> getArticleDetail(String accessToken, int id) async {
    final resp = await service.getArticleDetail(accessToken, id);

    if (resp.isSuccessful) {
      return ArticleDetail.fromJson(Utf8Util.utf8JsonDecode(resp.bodyString));
    } else {
      throw resp;
    }
  }

  @override
  Future<BaseResponse<ArticleModel>> getArticleList(String accessToken, int cursorId, int size) async {
    final resp = await service.getArticleList(accessToken, cursorId, size);

    if (resp.isSuccessful) {
      return BaseResponse<ArticleModel>.fromJson(
        Utf8Util.utf8JsonDecode(resp.bodyString),
        (json) => ArticleModel.fromJson(json as Map<String, dynamic>),
      );
    } else {
      throw resp;
    }
  }
}
