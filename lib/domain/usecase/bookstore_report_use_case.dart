import 'package:bookand/data/repository/bookstore_repository_impl.dart';
import 'package:bookand/domain/repository/bookstore_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/util/logger.dart';

part 'bookstore_report_use_case.g.dart';

@riverpod
BookstoreReportUseCase bookstoreReportUseCase(BookstoreReportUseCaseRef ref) {
  final repository = ref.read(bookstoreRepositoryProvider);
  return BookstoreReportUseCase(repository);
}

class BookstoreReportUseCase {
  final BookstoreRepository repository;

  BookstoreReportUseCase(this.repository);

  Future<void> bookstoreReport({
    required String name,
    required String address,
  }) async {
    try {
      await repository.bookstoreReport(name, address);
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }
}
