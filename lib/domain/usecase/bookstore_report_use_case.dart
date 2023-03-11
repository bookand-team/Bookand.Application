import 'package:bookand/data/repository/bookstore_repository_impl.dart';
import 'package:bookand/domain/repository/bookstore_repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/const/storage_key.dart';
import '../../core/util/logger.dart';

part 'bookstore_report_use_case.g.dart';

@riverpod
BookstoreReportUseCase bookstoreReportUseCase(BookstoreReportUseCaseRef ref) {
  final repository = ref.read(bookstoreRepositoryProvider);
  const storage = FlutterSecureStorage();

  return BookstoreReportUseCase(repository, storage);
}

class BookstoreReportUseCase {
  final BookstoreRepository repository;
  final FlutterSecureStorage storage;

  BookstoreReportUseCase(this.repository, this.storage);

  Future<void> bookstoreReport({
    required String name,
    required String address,
  }) async {
    try {
      final accessToken = await storage.read(key: accessTokenKey);
      await repository.bookstoreReport(accessToken!, name, address);
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }
}
