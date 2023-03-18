import 'package:bookand/data/datasource/bookstore/bookstore_remote_data_source_impl.dart';
import 'package:bookand/domain/model/bookstore/bookstore_report_request.dart';
import 'package:chopper/chopper.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/util/utf8_util.dart';
import '../../domain/model/error_response.dart';
import '../../domain/repository/bookstore_repository.dart';
import '../datasource/bookstore/bookstore_remote_data_source.dart';

part 'bookstore_repository_impl.g.dart';

@riverpod
BookstoreRepository bookstoreRepository(BookstoreRepositoryRef ref) {
  final bookstoreRemoteDataSource = ref.read(bookstoreRemoteDataSourceProvider);

  return BookstoreRepositoryImpl(bookstoreRemoteDataSource);
}

class BookstoreRepositoryImpl implements BookstoreRepository {
  final BookstoreRemoteDataSource bookstoreRemoteDataSource;

  BookstoreRepositoryImpl(this.bookstoreRemoteDataSource);

  @override
  Future<String> bookstoreReport(String accessToken, String name, String address) async {
    try {
      final bookstoreReportRequest = BookstoreReportRequest(address, name);
      final data =
          await bookstoreRemoteDataSource.bookstoreReport(accessToken, bookstoreReportRequest);
      return data.result;
    } on Response catch (e) {
      throw ErrorResponse.fromJson(Utf8Util.utf8JsonDecode(e.bodyString));
    } catch (_) {
      rethrow;
    }
  }
}
