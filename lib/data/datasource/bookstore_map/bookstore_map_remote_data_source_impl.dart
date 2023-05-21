import 'package:bookand/core/util/utf8_util.dart';
import 'package:bookand/data/service/bookstore_map_service.dart';
import 'package:bookand/domain/model/bookstore/bookstore_map_detail_model.dart';
import 'package:bookand/domain/model/bookstore/response/bookstore_map_response.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'bookstore_remote_data_source.dart';

part 'bookstore_map_remote_data_source_impl.g.dart';

@riverpod
BookstoreMapRemoteDataSource bookstoreMapRemoteDataSource(
    BookstoreMapRemoteDataSourceRef ref) {
  final bookstoreMapService = ref.read(bookstoreMapServiceProvider);

  return BookstoreMapRemoteDataSourceImpl(bookstoreMapService);
}

class BookstoreMapRemoteDataSourceImpl implements BookstoreMapRemoteDataSource {
  final BookstoreMapService service;

  BookstoreMapRemoteDataSourceImpl(this.service);

  @override
  Future<BookStoreGetAllResponse> getBookStoreAll(String accessToken) async {
    final resp = await service.getBookstoreMap(accessToken);
    if (resp.isSuccessful) {
      return BookStoreGetAllResponse.fromJson(
          Utf8Util.utf8JsonDecode(resp.bodyString));
    } else {
      throw resp;
    }
  }

  @override
  Future<BookstoreMapDetailModel> getBookstoreMapDetail(
      String accessToken, int id) async {
    final resp = await service.getBookstoreMapDetail(accessToken, id);
    if (resp.isSuccessful) {
      return BookstoreMapDetailModel.fromJson(
          Utf8Util.utf8JsonDecode(resp.bodyString));
    } else {
      throw resp;
    }
  }
}
