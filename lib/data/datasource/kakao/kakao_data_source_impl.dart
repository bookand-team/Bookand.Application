import 'dart:convert';
import 'dart:io';

import 'package:bookand/domain/model/kakao/search_keyword_request.dart';
import 'package:bookand/domain/model/kakao/search_keyword_response.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:http/http.dart' as http;

import '../../../core/util/logger.dart';
import 'kakao_data_source.dart';

part 'kakao_data_source_impl.g.dart';

@riverpod
KakaoDataSource kakaoDataSource(KakaoDataSourceRef ref) => KakaoDataSourceImpl();

class KakaoDataSourceImpl implements KakaoDataSource {
  @override
  Future<SearchKeywordResponse> searchKeyword(SearchKeywordRequest request) async {
    const kakaoApiKey = String.fromEnvironment('KAKAO_REST_API_KEY');

    if (kakaoApiKey.isEmpty) {
      throw ('카카오 api key를 가져올 수 없음.');
    }

    final requestUrl =
        'https://dapi.kakao.com/v2/local/search/keyword.json?query=${request.query}&category_group_code=${request.categoryGroupCode ?? ''}&x=${request.x ?? ''}&y=${request.y ?? ''}&radius=${request.radius ?? ''}&rect=${request.rect ?? ''}&page=${request.page ?? 1}&size=${request.size ?? 15}&sort=${request.sort ?? ''}';
    final resp = await http.get(
      Uri.parse(requestUrl),
      headers: {'Authorization': 'KakaoAK $kakaoApiKey'},
    );

    if (resp.statusCode == HttpStatus.ok) {
      logger.i(
          '카카오 키워드 검색 결과\n[URI] ${resp.request?.url}\n[Status Code] ${resp.statusCode}\n[Body] ${resp.body}');
      final jsonData = jsonDecode(resp.body);
      return SearchKeywordResponse.fromJson(jsonData);
    } else {
      throw ('카카오 키워드 검색 에러\n[URI] ${resp.request?.url}\n[Status Code] ${resp.statusCode}\n[Body] ${resp.body}');
    }
  }
}
