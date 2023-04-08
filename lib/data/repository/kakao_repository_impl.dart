import 'package:bookand/data/datasource/kakao/kakao_data_source.dart';
import 'package:bookand/data/datasource/kakao/kakao_data_source_impl.dart';
import 'package:bookand/domain/model/kakao/search_keyword_response.dart';
import 'package:chopper/chopper.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/util/utf8_util.dart';
import '../../domain/model/error_response.dart';
import '../../domain/repository/kakao_repository.dart';
import '../datasource/token/token_local_data_source.dart';
import '../datasource/token/token_local_data_source_impl.dart';

part 'kakao_repository_impl.g.dart';

@riverpod
KakaoRepository kakaoRepository(KakaoRepositoryRef ref) {
  final kakaoDataSource = ref.read(kakaoDataSourceProvider);
  final tokenLocalDataSource = ref.read(tokenLocalDataSourceProvider);

  return KakaoRepositoryImpl(kakaoDataSource, tokenLocalDataSource);
}

class KakaoRepositoryImpl implements KakaoRepository {
  final KakaoDataSource kakaoDataSource;
  final TokenLocalDataSource tokenLocalDataSource;

  KakaoRepositoryImpl(this.kakaoDataSource, this.tokenLocalDataSource);

  @override
  Future<SearchKeywordResponse> searchKeyword(String query, int page, int size) async {
    try {
      final accessToken = await tokenLocalDataSource.getAccessToken();
      return await kakaoDataSource.searchKeyword(accessToken, query, page, size);
    } on Response catch (e) {
      throw ErrorResponse.fromJson(Utf8Util.utf8JsonDecode(e.bodyString));
    } catch (_) {
      rethrow;
    }
  }
}
