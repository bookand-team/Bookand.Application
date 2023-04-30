import 'package:bookand/data/datasource/bookstore_map/bookstore_map_remote_data_source_impl.dart';
import 'package:bookand/data/datasource/bookstore_map/bookstore_remote_data_source.dart';
import 'package:bookand/data/datasource/token/token_local_data_source.dart';
import 'package:bookand/data/datasource/token/token_local_data_source_impl.dart';
import 'package:bookand/domain/model/bookstore/bookstore_map_detail_model.dart';
import 'package:bookand/domain/model/bookstore/bookstore_map_model.dart';
import 'package:bookand/domain/repository/bookstore_map_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'bookstore_map_repository_impl.g.dart';

@riverpod
BookstoreMapRepository bookstoreMapRepository(BookstoreMapRepositoryRef ref) {
  final bookstoreMapRemoteDataSource =
      ref.read(bookstoreMapRemoteDataSourceProvider);
  final tokenLocalDataSource = ref.read(tokenLocalDataSourceProvider);

  return BookstoreMapRepositoryImpl(
      bookstoreMapRemoteDataSource, tokenLocalDataSource);
}

class BookstoreMapRepositoryImpl implements BookstoreMapRepository {
  final BookstoreMapRemoteDataSource bookstoreMapRemoteDataSource;
  final TokenLocalDataSource tokenLocalDataSource;

  BookstoreMapRepositoryImpl(
      this.bookstoreMapRemoteDataSource, this.tokenLocalDataSource);

  @override
  Future<BookStoreGetAllResponse> getBookstoreAll() async {
    // try {
    // } on Response catch (e) {
    //   throw ErrorResponse.fromJson(Utf8Util.utf8JsonDecode(e.bodyString));
    // } catch (_) {
    //   rethrow;
    // }
    final accessToken = await tokenLocalDataSource.getAccessToken();
    return await bookstoreMapRemoteDataSource.getBookStoreAll(accessToken);
  }

  @override
  Future<BookstoreMapDetailModel> getBookstoreMapDetail(int id) async {
    final accessToken = await tokenLocalDataSource.getAccessToken();
    return await bookstoreMapRemoteDataSource.getBookstoreMapDetail(
        accessToken, id);
  }
}
