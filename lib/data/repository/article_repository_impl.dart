import 'package:bookand/data/datasource/article/article_remote_data_source.dart';
import 'package:bookand/data/datasource/article/article_remote_data_source_impl.dart';
import 'package:bookand/data/datasource/token/token_local_data_source.dart';
import 'package:bookand/domain/model/article/article_detail.dart';
import 'package:bookand/domain/model/article/article_model.dart';
import 'package:chopper/chopper.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/util/utf8_util.dart';
import '../../domain/model/error_response.dart';
import '../../domain/repository/article_repository.dart';
import '../datasource/token/token_local_data_source_impl.dart';

part 'article_repository_impl.g.dart';

@riverpod
ArticleRepository articleRepository(ArticleRepositoryRef ref) {
  final articleRemoteDataSource = ref.read(articleRemoteDataSourceProvider);
  final tokenLocalDataSource = ref.read(tokenLocalDataSourceProvider);

  return ArticleRepositoryImpl(articleRemoteDataSource, tokenLocalDataSource);
}

class ArticleRepositoryImpl implements ArticleRepository {
  final ArticleRemoteDataSource articleRemoteDataSource;
  final TokenLocalDataSource tokenLocalDataSource;

  ArticleRepositoryImpl(this.articleRemoteDataSource, this.tokenLocalDataSource);

  @override
  Future<ArticleDetail> getArticleDetail(int id) async {
    try {
      final accessToken = await tokenLocalDataSource.getAccessToken();
      return await articleRemoteDataSource.getArticleDetail(accessToken, id);
    } on Response catch (e) {
      throw ErrorResponse.fromJson(Utf8Util.utf8JsonDecode(e.bodyString));
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<ArticleModel> getArticleList(int page) async {
    try {
      final accessToken = await tokenLocalDataSource.getAccessToken();
      final resp = await articleRemoteDataSource.getArticleList(accessToken, page);
      return resp.data;
    } on Response catch (e) {
      throw ErrorResponse.fromJson(Utf8Util.utf8JsonDecode(e.bodyString));
    } catch (_) {
      rethrow;
    }
  }
}
