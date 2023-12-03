import 'package:bookand/data/datasource/issue/issue_remote_data_source.dart';
import 'package:bookand/data/datasource/issue/issue_remote_data_source_impl.dart';
import 'package:bookand/domain/model/issue_report_request.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/repository/issue_repository.dart';
import '../datasource/token/token_local_data_source.dart';
import '../datasource/token/token_local_data_source_impl.dart';

part 'issue_repository_impl.g.dart';

@riverpod
IssueRepository issueRepository(IssueRepositoryRef ref) {
  final issueRemoteDataSource = ref.read(issueRemoteDataSourceProvider);
  final tokenLocalDataSource = ref.read(tokenLocalDataSourceProvider);
  return IssueRepositoryImpl(issueRemoteDataSource, tokenLocalDataSource);
}

class IssueRepositoryImpl implements IssueRepository {
  final IssueRemoteDataSource issueRemoteDataSource;
  final TokenLocalDataSource tokenLocalDataSource;

  IssueRepositoryImpl(this.issueRemoteDataSource, this.tokenLocalDataSource);

  @override
  Future<void> reportIssue(IssueReportRequest issueReportRequest) async {
    try {
      final accessToken = await tokenLocalDataSource.getAccessToken();
      await issueRemoteDataSource.reportIssue(accessToken, issueReportRequest);
    } catch (_) {
      rethrow;
    }
  }
}
