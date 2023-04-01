import 'package:bookand/domain/model/kakao/search_keyword_response.dart';

abstract class KakaoDataSource {
  Future<SearchKeywordResponse> searchKeyword(String accessToken, String query, int page, int size);
}
