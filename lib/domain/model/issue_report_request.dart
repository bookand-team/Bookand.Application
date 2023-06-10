import 'package:freezed_annotation/freezed_annotation.dart';

part 'issue_report_request.freezed.dart';
part 'issue_report_request.g.dart';

@freezed
class IssueReportRequest with _$IssueReportRequest {
  const factory IssueReportRequest(
      {required String issuedAt,
      required String issueContent,
      required String issueReportResponseEmail,
      List<String>? issueImages,
      required bool sendLogs,
      required String deviceOS,
      String? logFilePath}) = _IssueReportRequest;

  factory IssueReportRequest.fromJson(Map<String, Object?> json) =>
      _$IssueReportRequestFromJson(json);
}
