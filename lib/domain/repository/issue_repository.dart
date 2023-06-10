import '../model/issue_report_request.dart';

abstract interface class IssueRepository {
  Future<void> reportIssue(IssueReportRequest issueReportRequest);
}
