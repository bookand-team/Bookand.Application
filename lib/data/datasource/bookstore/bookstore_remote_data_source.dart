import 'package:bookand/domain/model/bookstore/bookstore_report_request.dart';
import 'package:bookand/domain/model/bookstore/bookstore_test.dart';

import '../../../domain/model/bookstore/bookstore_detail.dart';
import '../../../domain/model/result_response.dart';

abstract class BookstoreRemoteDataSource {
  Future<ResultResponse> bookstoreReport(
    String accessToken,
    BookstoreReportRequest bookstoreReportRequest,
  );

  Future<BookstoreDetail> getBookstoreDetail(
    String accessToken,
    int id,
  );

  /// 처음에 전부 받을 때 가정, userToken으로 bookMark여부, accesToken은 모르겠음
  Future<BookstoreTest> getBookstoreTest(String accessToken, String userToken);
}
