import 'package:bookand/data/datasource/bookstore/bookstore_remote_data_source_impl.dart';
import 'package:bookand/data/datasource/token/token_local_data_source.dart';
import 'package:bookand/data/datasource/token/token_local_data_source_impl.dart';
import 'package:bookand/domain/model/bookstore/bookstore_detail.dart';
import 'package:bookand/domain/model/bookstore/bookstore_report_request.dart';
import 'package:bookand/domain/model/bookstore/bookstore_test.dart';
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
  final tokenLocalDataSource = ref.read(tokenLocalDataSourceProvider);

  return BookstoreRepositoryImpl(bookstoreRemoteDataSource, tokenLocalDataSource);
}

class BookstoreRepositoryImpl implements BookstoreRepository {
  final BookstoreRemoteDataSource bookstoreRemoteDataSource;
  final TokenLocalDataSource tokenLocalDataSource;

  BookstoreRepositoryImpl(this.bookstoreRemoteDataSource, this.tokenLocalDataSource);

  @override
  Future<String> bookstoreReport(String name, String address) async {
    try {
      final bookstoreReportRequest = BookstoreReportRequest(address, name);
      final accessToken = await tokenLocalDataSource.getAccessToken();
      final data = await bookstoreRemoteDataSource.bookstoreReport(
        accessToken,
        bookstoreReportRequest,
      );
      return data.result;
    } on Response catch (e) {
      throw ErrorResponse.fromJson(Utf8Util.utf8JsonDecode(e.bodyString));
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<BookstoreDetail> getBookstoreDetail(int id) async {
    try {
      final accessToken = await tokenLocalDataSource.getAccessToken();
      return await bookstoreRemoteDataSource.getBookstoreDetail(accessToken, id);
    } on Response catch (e) {
      throw ErrorResponse.fromJson(Utf8Util.utf8JsonDecode(e.bodyString));
    } catch (_) {
      rethrow;
    }
  }

  /// 처음에 전부 다 받는다는 test 기능 구현
  @override
  Future<BookstoreTest> getBookTest(String userToken)async {
    try {
      final accessToken = await tokenLocalDataSource.getAccessToken();
      return await bookstoreRemoteDataSource.getBookstoreTest(accessToken, userToken);
    } on Response catch (e){
      throw ErrorResponse.fromJson(Utf8Util.utf8JsonDecode(e.bodyString));
    }
     catch (_) {
      rethrow;
    }
  }
}
