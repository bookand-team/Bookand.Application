import 'package:bookand/domain/model/kakao/search_keyword_request.dart';
import 'package:bookand/domain/model/kakao/search_keyword_response.dart';

abstract class KakaoDataSource {
  Future<SearchKeywordResponse> searchKeyword(SearchKeywordRequest request);
}
