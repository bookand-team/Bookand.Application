import 'dart:io';

import 'package:archive/archive_io.dart';
import 'package:bookand/domain/model/error_report_model.dart';
import 'package:bookand/domain/model/issue_report_request.dart';
import 'package:bookand/domain/repository/issue_repository.dart';
import 'package:bookand/domain/usecase/upload_files_use_case.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/util/logger.dart';
import '../../data/repository/issue_repository_impl.dart';

part 'report_issue_use_case.g.dart';

@riverpod
ReportIssueUseCase reportIssueUseCase(ReportIssueUseCaseRef ref) {
  final issueRepository = ref.read(issueRepositoryProvider);
  final uploadFilesUseCase = ref.read(uploadFilesUseCaseProvider);

  return ReportIssueUseCase(issueRepository, uploadFilesUseCase);
}

class ReportIssueUseCase {
  final IssueRepository issueRepository;
  final UploadFilesUseCase uploadFilesUseCase;

  ReportIssueUseCase(
    this.issueRepository,
    this.uploadFilesUseCase,
  );

  Future<void> reportIssue(ErrorReportModel errorReportModel) async {
    final deviceOS = switch (defaultTargetPlatform) {
      TargetPlatform.android => 'ANDROID',
      TargetPlatform.iOS => 'IOS',
      TargetPlatform.fuchsia => 'N/A',
      TargetPlatform.macOS => 'N/A',
      TargetPlatform.windows => 'N/A',
      TargetPlatform.linux => 'N/A'
    };

    List<String>? imageUrlList;
    if (errorReportModel.images.isNotEmpty) {
      final files = await uploadFilesUseCase.uploadFiles(errorReportModel.images);
      imageUrlList = files.map((e) => e.fileUrl).toList();
    }

    String? logPath;
    if (errorReportModel.sendLog) {
      logPath = await _getLogPath();
    }

    final errorDateTime = DateFormat('yyyy/MM/dd HH:mm').parse(errorReportModel.errorDate);
    final errorDateTimeFormatting = DateFormat('yyyy-MM-ddTHH:mm:ss').format(errorDateTime);

    final issueReportRequest = IssueReportRequest(
        issuedAt: errorDateTimeFormatting,
        issueContent: errorReportModel.errorContent,
        issueReportResponseEmail: errorReportModel.email,
        issueImages: imageUrlList,
        sendLogs: errorReportModel.sendLog,
        deviceOS: deviceOS,
        logFilePath: logPath);

    await issueRepository.reportIssue(issueReportRequest);
  }

  Future<String?> _getLogPath() async {
    final appDocDir = await getApplicationDocumentsDirectory();
    final logDir = Directory('${appDocDir.path}/logs');
    final isExists = await logDir.exists();

    if (!isExists) {
      logger.e('로그 폴더를 찾을 수 없음.');
      return null;
    }

    try {
      final deviceInfoPlugin = DeviceInfoPlugin();
      var deviceInfo = '';

      switch (defaultTargetPlatform) {
        case TargetPlatform.android:
          final androidInfo = await deviceInfoPlugin.androidInfo;
          deviceInfo = '${androidInfo.model}_Android ${androidInfo.version.release}';
        case TargetPlatform.iOS:
          final iosInfo = await deviceInfoPlugin.iosInfo;
          deviceInfo = '${iosInfo.model}_iOS ${iosInfo.systemVersion}';
        default:
          deviceInfo = 'UnknownDeviceInfo';
      }

      final zipFileName =
          '${deviceInfo}_${DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now())}_logs.zip';
      final zipFilePath = '${appDocDir.path}/$zipFileName';
      _startCompressLogFile(zipFilePath, logDir);
      return zipFilePath;
    } catch (e, stack) {
      logger.e(e.toString(), e, stack);
      return null;
    }
  }

  void _startCompressLogFile(String path, Directory logDir) {
    final encoder = ZipFileEncoder();
    encoder.create(path);
    logDir.listSync().forEach((e) {
      encoder.addFile(File(e.path));
    });
    encoder.close();
  }
}
