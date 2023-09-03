import 'package:bookand/data/repository/bookstore_repository_impl.dart';
import 'package:bookand/domain/model/bookmark/bookmark_model.dart';
import 'package:bookand/domain/model/bookstore/bookstore_map_model.dart';
import 'package:bookand/presentation/provider/bookmark/bookmark_store_provider.dart';
import 'package:bookand/presentation/provider/map/map_bookstores_provider.dart';
import 'package:bookand/presentation/utils/marker_util.dart';
import 'package:flutter/services.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/util/logger.dart';
import '../../data/repository/bookmark_repository_impl.dart';
import '../../domain/model/article/article_model.dart';
import '../../domain/model/bookstore/bookstore_detail.dart';
import '../../domain/model/error_response.dart';
import '../../domain/usecase/delete_bookmark_use_case.dart';

part 'bookstore_provider.freezed.dart';

part 'bookstore_provider.g.dart';

@freezed
class BookstoreState with _$BookstoreState {
  const factory BookstoreState({
    required BookstoreDetail bookstoreDetail,
    required Set<Marker> markers,
  }) = _BookstoreState;
}

@riverpod
class BookstoreStateNotifier extends _$BookstoreStateNotifier {
  @override
  BookstoreState build() => BookstoreState(bookstoreDetail: BookstoreDetail(), markers: {});

  void fetchBookstoreDetail(int id) async {
    try {
      final bookstoreDetail = await ref.read(bookstoreRepositoryProvider).getBookstoreDetail(id);
      final marker = await createMarker(
        id: bookstoreDetail.id.toString(),
        label: bookstoreDetail.name ?? '',
        latitude: double.parse(bookstoreDetail.info?.latitude ?? '37.541'),
        longitude: double.parse(bookstoreDetail.info?.longitude ?? '126.986'),
      );
      state = BookstoreState(bookstoreDetail: bookstoreDetail, markers: {marker});
    } on ErrorResponse catch (e, stack) {
      logger.e('[${e.code}] ${e.message}', e.log, stack);
    } catch (e, stack) {
      logger.e(e.toString(), e, stack);
    }
  }

  void updateBookstoreBookmark() async {
    final isBookmark = state.bookstoreDetail.isBookmark ?? false;
    final bookstoreDetail = state.bookstoreDetail.copyWith(isBookmark: !isBookmark);

    state = state.copyWith(bookstoreDetail: bookstoreDetail);

    BookStoreMapModel? model;

    final iter = ref
        .read(mapBookStoreNotifierProvider)
        .where((element) => element.id == state.bookstoreDetail.id);
    if (iter.isNotEmpty) {
      model = iter.first;
      ref.read(mapBookStoreNotifierProvider.notifier).updateBookmarked(model.id!, !isBookmark);
    }

    if (isBookmark) {
      //bookmark 페이지 연동
      if (model != null) {
        ref.read(bookmarkStoreNotifierProvider.notifier).deleteOnlyState([model.id!]);
      }
      await ref
          .read(deleteBookmarkUseCaseProvider)
          .deleteBookmarkBookstoreList([state.bookstoreDetail.id ?? -1]);
    } else {
      //bookmark 페이지 연동
      if (model != null) {
        ref.read(bookmarkStoreNotifierProvider.notifier).addOnlyState(BookmarkModel(
            bookmarkId: model.id,
            image: model.mainImage,
            title: model.name,
            location: model.address));
      }

      await ref
          .read(bookmarkRepositoryProvider)
          .addBookstoreBookmark(state.bookstoreDetail.id ?? -1);
    }
  }

  void updateArticleBookmark(int index) async {
    try {
      final List<ArticleContent> articleList =
          List.from(state.bookstoreDetail.articleResponse ?? []);
      final isBookmark = articleList[index].isBookmark;

      articleList[index].isBookmark = !isBookmark;

      final bookstoreDetail = state.bookstoreDetail.copyWith(articleResponse: articleList);
      state = state.copyWith(bookstoreDetail: bookstoreDetail);

      if (isBookmark) {
        await ref
            .read(deleteBookmarkUseCaseProvider)
            .deleteBookmarkArticleList([state.bookstoreDetail.id ?? -1]);
      } else {
        await ref
            .read(bookmarkRepositoryProvider)
            .addArticleBookmark(state.bookstoreDetail.id ?? -1);
      }
    } catch (e) {
      logger.e(e);
    }
  }

  void copyAddress() {
    final address = state.bookstoreDetail.info?.address;
    if (address == null) return;

    Clipboard.setData(ClipboardData(text: address));
  }
}
