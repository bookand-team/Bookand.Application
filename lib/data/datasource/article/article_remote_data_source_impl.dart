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
  Future<ArticleDetail> getArticleDetail(String accessToken, int id) {
    // TODO: implement getArticleDetail
    throw UnimplementedError();
  }

  @override
  Future<BaseResponse<ArticleModel>> getArticleList(String accessToken, int page) async {
    final resp = await service.getArticleList(accessToken, page);

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
