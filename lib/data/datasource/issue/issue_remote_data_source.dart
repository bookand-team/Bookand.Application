import '../../../domain/model/issue_report_request.dart';

abstract interface class IssueRemoteDataSource {
  Future<void> reportIssue(String accessToken, IssueReportRequest issueReportRequest);
}
