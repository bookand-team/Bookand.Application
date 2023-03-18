import 'package:bookand/data/datasource/kakao/kakao_data_source.dart';
import 'package:bookand/data/datasource/kakao/kakao_data_source_impl.dart';
import 'package:bookand/domain/model/kakao/search_keyword_request.dart';
import 'package:bookand/domain/model/kakao/search_keyword_response.dart';
import 'package:chopper/chopper.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/util/utf8_util.dart';
import '../../domain/model/error_response.dart';
import '../../domain/repository/kakao_repository.dart';

part 'kakao_repository_impl.g.dart';

@riverpod
KakaoRepository kakaoRepository(KakaoRepositoryRef ref) {
  final kakaoDataSource = ref.read(kakaoDataSourceProvider);

  return KakaoRepositoryImpl(kakaoDataSource);
}

class KakaoRepositoryImpl implements KakaoRepository {
  final KakaoDataSource kakaoDataSource;

  KakaoRepositoryImpl(this.kakaoDataSource);

  @override
  Future<SearchKeywordResponse> searchKeyword(String query, int page, int size) async {
    try {
      return await kakaoDataSource
          .searchKeyword(SearchKeywordRequest(query, size: size, page: page));
    } on Response catch (e) {
      throw ErrorResponse.fromJson(Utf8Util.utf8JsonDecode(e.bodyString));
    } catch (_) {
      rethrow;
    }
  }
}
