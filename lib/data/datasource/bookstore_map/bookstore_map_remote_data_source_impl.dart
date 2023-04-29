import 'package:bookand/data/datasource/bookstore_map/bookstore_remote_data_source.dart';
import 'package:bookand/data/service/bookstore_map_service.dart';
import 'package:bookand/domain/model/bookstore/bookstore_map_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/util/utf8_util.dart';

part 'bookstore_map_remote_data_source_impl.g.dart';

@riverpod
BookstoreMapRemoteDataSource bookstoreMapRemoteDataSource(
    BookstoreMapRemoteDataSourceRef ref) {
  final bookstoreService = ref.read(bookstoreServiceProvider);

  return BookstoreMapRemoteDataStoreImpl(bookstoreService);
}

class BookstoreMapRemoteDataStoreImpl implements BookstoreMapRemoteDataSource {
  final BookstoreMapService service;

  BookstoreMapRemoteDataStoreImpl(this.service);

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
}
