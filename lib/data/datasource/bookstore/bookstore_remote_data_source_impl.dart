import 'package:bookand/data/datasource/bookstore/bookstore_remote_data_source.dart';
import 'package:bookand/data/service/bookstore_service.dart';
import 'package:bookand/domain/model/bookstore/bookstore_detail.dart';
import 'package:bookand/domain/model/bookstore/bookstore_report_request.dart';
import 'package:bookand/domain/model/result_response.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/util/utf8_util.dart';

part 'bookstore_remote_data_source_impl.g.dart';

@riverpod
BookstoreRemoteDataSource bookstoreRemoteDataSource(
    BookstoreRemoteDataSourceRef ref) {
  final bookstoreService = ref.read(bookstoreServiceProvider);

  return BookstoreRemoteDataStoreImpl(bookstoreService);
}

class BookstoreRemoteDataStoreImpl implements BookstoreRemoteDataSource {
  final BookstoreService service;

  BookstoreRemoteDataStoreImpl(this.service);

  @override
  Future<ResultResponse> bookstoreReport(
    String accessToken,
    BookstoreReportRequest bookstoreReportRequest,
  ) async {
    final resp = await service.bookstoreReport(
        accessToken, bookstoreReportRequest.toJson());

    if (resp.isSuccessful) {
      return ResultResponse.fromJson(Utf8Util.utf8JsonDecode(resp.bodyString));
    } else {
      throw resp;
    }
  }

  @override
  Future<BookstoreDetail> getBookstoreDetail(String accessToken, int id) async {
    final resp = await service.getBookstoreDetail(accessToken, id);

    if (resp.isSuccessful) {
      return BookstoreDetail.fromJson(Utf8Util.utf8JsonDecode(resp.bodyString));
    } else {
      throw resp;
    }
  }
}
