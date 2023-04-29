import 'package:bookand/domain/model/bookstore/bookstore_test.dart';

import '../model/bookstore/bookstore_detail.dart';

abstract class BookstoreRepository {
  Future<String> bookstoreReport(String name, String address);

  Future<BookstoreDetail> getBookstoreDetail(int id);

  /// 처음에 전부 받는다는 가정
  Future<BookstoreTest> getBookTest(String memberToken);
}
