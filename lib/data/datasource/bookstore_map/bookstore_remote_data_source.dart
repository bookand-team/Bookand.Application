import 'package:bookand/domain/model/bookstore/bookstore_map_model.dart';

abstract class BookstoreMapRemoteDataSource {
//map에서 서점 데이터 전부 다 받을 때 사용
  Future<BookStoreGetAllResponse> getBookStoreAll(String accessToken);
}
