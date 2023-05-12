import 'package:bookand/domain/model/bookstore/bookstore_report_request.dart';

import '../../../domain/model/bookstore/bookstore_detail.dart';
import '../../../domain/model/result_response.dart';

abstract interface class BookstoreRemoteDataSource {
  Future<ResultResponse> bookstoreReport(
    String accessToken,
    BookstoreReportRequest bookstoreReportRequest,
  );

  Future<BookstoreDetail> getBookstoreDetail(
    String accessToken,
    int id,
  );
}
