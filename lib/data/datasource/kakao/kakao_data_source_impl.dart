import 'dart:io';

import 'package:bookand/data/service/kakao_service.dart';
import 'package:bookand/domain/model/kakao/search_keyword_response.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/util/utf8_util.dart';
import 'kakao_data_source.dart';

part 'kakao_data_source_impl.g.dart';

@riverpod
KakaoDataSource kakaoDataSource(KakaoDataSourceRef ref) {
  final kakaoService = ref.read(kakaoServiceProvider);

  return KakaoDataSourceImpl(kakaoService);
}

class KakaoDataSourceImpl implements KakaoDataSource {
  final KakaoService service;

  KakaoDataSourceImpl(this.service);

  @override
  Future<SearchKeywordResponse> searchKeyword(
      String accessToken, String query, int page, int size) async {
    final resp = await service.searchKeyword(accessToken, query, page, size);

    if (resp.statusCode == HttpStatus.ok) {
      return SearchKeywordResponse.fromJson(Utf8Util.utf8JsonDecode(resp.bodyString));
    } else {
      throw resp;
    }
  }
}
