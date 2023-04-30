import 'package:bookand/domain/model/bookstore/bookstore_map_detail_model.dart';
import 'package:bookand/domain/model/bookstore/bookstore_map_model.dart';

abstract class BookstoreMapRemoteDataSource {
//map에서 서점 데이터 전부 다 받을 때 사용
  Future<BookStoreGetAllResponse> getBookStoreAll(String accessToken);
  // 디테일 정보 하나 받을 때
  Future<BookstoreMapDetailModel> getBookstoreMapDetail(
      String accessToken, int id);
}
