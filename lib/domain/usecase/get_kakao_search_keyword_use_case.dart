import 'package:bookand/data/repository/kakao_repository_impl.dart';
import 'package:bookand/domain/model/kakao/search_keyword_response.dart';
import 'package:bookand/domain/repository/kakao_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_kakao_search_keyword_use_case.g.dart';

@riverpod
GetKakaoSearchKeywordUseCase getKakaoSearchKeywordUseCase(GetKakaoSearchKeywordUseCaseRef ref) {
  final repository = ref.read(kakaoRepositoryProvider);

  return GetKakaoSearchKeywordUseCase(repository);
}

class GetKakaoSearchKeywordUseCase {
  final KakaoRepository repository;

  GetKakaoSearchKeywordUseCase(this.repository);

  Future<SearchKeywordResponse> getSearchList(String query, {int page = 1, int size = 15}) async {
    return await repository.searchKeyword(query, page, size);
  }
}
