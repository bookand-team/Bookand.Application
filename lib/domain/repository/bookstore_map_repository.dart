import 'package:bookand/domain/model/bookstore/bookstore_map_detail_model.dart';
import 'package:bookand/domain/model/bookstore/bookstore_map_model.dart';

abstract class BookstoreMapRepository {
  //map에서 모든 bookstore 받을 때
  Future<BookStoreGetAllResponse> getBookstoreAll();
  Future<BookstoreMapDetailModel> getBookstoreMapDetail(int id);
}
