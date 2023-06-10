import 'dart:io';

import 'package:bookand/core/config/app_config.dart';
import 'package:bookand/domain/model/issue_report_request.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/util/logger.dart';
import '../../../core/util/utf8_util.dart';
import '../../../domain/model/error_response.dart';
import 'issue_remote_data_source.dart';

part 'issue_remote_data_source_impl.g.dart';

@riverpod
IssueRemoteDataSource issueRemoteDataSource(IssueRemoteDataSourceRef ref) =>
    IssueRemoteDataSourceImpl();

class IssueRemoteDataSourceImpl implements IssueRemoteDataSource {
  @override
  Future<void> reportIssue(String accessToken, IssueReportRequest issueReportRequest) async {
    final request =
        http.MultipartRequest("POST", Uri.parse('${AppConfig.instance.baseUrl}/api/v1/issues'));

    final logFilePath = issueReportRequest.logFilePath;
    if (logFilePath != null) {
      request.files.add(await http.MultipartFile.fromPath('logFile', logFilePath));
    }

    final json = issueReportRequest.toJson();
    json.remove('logFile');
    final body = json.map((key, value) => MapEntry(key, value.toString()));
    request.fields.addAll(body);
    request.headers.addAll({'Authorization': 'Bearer $accessToken'});

    final resp = await request.send();
    final bodyBytes = await resp.stream.single;
    final bodyString = Utf8Util.decode(bodyBytes);
    logger.i('[${resp.statusCode}] $bodyString');

    if (resp.statusCode != HttpStatus.ok) {
      throw ErrorResponse.fromJson(Utf8Util.utf8JsonDecode(bodyString));
    }
  }
}
