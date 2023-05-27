import 'package:bookand/domain/model/kakao/search_keyword_response.dart';

abstract interface class KakaoDataSource {
  Future<SearchKeywordResponse> searchKeyword(String accessToken, String query, int page, int size);
}
