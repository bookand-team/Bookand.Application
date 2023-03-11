import 'package:bookand/domain/model/bookstore/bookstore_report_request.dart';

import '../../../domain/model/result_response.dart';

abstract class BookstoreRemoteDataSource {
  Future<ResultResponse> bookstoreReport(
    String accessToken,
    BookstoreReportRequest bookstoreReportRequest,
  );
}
