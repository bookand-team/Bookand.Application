import '../model/kakao/search_keyword_response.dart';

abstract interface class KakaoRepository {
  Future<SearchKeywordResponse> searchKeyword(String query, int page, int size);
}
