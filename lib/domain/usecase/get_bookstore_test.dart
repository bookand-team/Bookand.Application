import 'package:bookand/data/repository/bookstore_repository_impl.dart';
import 'package:bookand/domain/repository/bookstore_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/util/logger.dart';

part 'get_bookstore_test.g.dart';

@riverpod
GetBookstoreTestUseCase getBookstoreTestUseCase(GetBookstoreTestUseCaseRef ref) {
  final repository = ref.read(bookstoreRepositoryProvider);
  return GetBookstoreTestUseCase(repository);
}


///bookstore를 전부 처음에 받아올 때 가정 user case
class GetBookstoreTestUseCase {
  final BookstoreRepository repository;

  GetBookstoreTestUseCase(this.repository);

/// user token을 통해 bookmark여부 감지 후 전부 받아오는 케이스 
  Future<void> bookstoreReport({
    required String userToken,
  }) async {
    try {
      await repository.getBookTest(userToken);
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }
}
