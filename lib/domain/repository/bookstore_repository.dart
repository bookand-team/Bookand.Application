import '../model/bookstore/bookstore_detail.dart';

abstract class BookstoreRepository {
  Future<String> bookstoreReport(String name, String address);

  Future<BookstoreDetail> getBookstoreDetail(int id);
}
