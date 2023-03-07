import 'package:bookand/domain/model/kakao/search_keyword_response.dart';
import 'package:bookand/domain/usecase/get_kakao_search_keyword_use_case.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/util/logger.dart';

part 'kakao_search_keyword_provider.g.dart';

@riverpod
class KakaoSearchKeywordStateNotifier extends _$KakaoSearchKeywordStateNotifier {
  SearchKeywordResponse? searchResult;
  int page = 0;
  bool isEnd = false;
  String query = '';

  @override
  List<SearchKeywordDocument> build() => [];

  void searchKeyword() async {
    try {
      searchResult = await ref.read(getKakaoSearchKeywordUseCaseProvider).getSearchList(query);

      page = searchResult == null ? 0 : 1;

      state = searchResult?.documents ?? [];
    } catch (e, stack) {
      logger.e(e, e, stack);
    }
  }

  void nextSearchKeyword() async {
    try {
      if (searchResult == null) return;

      if (searchResult!.meta.isEnd) {
        isEnd = true;
        return;
      }

      searchResult = await ref
          .read(getKakaoSearchKeywordUseCaseProvider)
          .getSearchList(searchResult!.meta.sameName.keyword, page: page);

      if (page < searchResult!.meta.pageableCount) {
        page++;
      }

      state = state + searchResult!.documents;
    } catch (e, stack) {
      logger.e(e, e, stack);
    }
  }

  void resetSearchResult() {
    searchResult = null;
    page = 0;
    isEnd = false;
    state = [];
  }
}
