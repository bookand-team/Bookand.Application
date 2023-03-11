import 'package:bookand/data/datasource/bookstore/bookstore_remote_data_source_impl.dart';
import 'package:bookand/domain/model/bookstore/bookstore_report_request.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

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
    final bookstoreReportRequest = BookstoreReportRequest(address, name);
    final data = await bookstoreRemoteDataSource.bookstoreReport(accessToken, bookstoreReportRequest);
    return data.result;
  }
}
