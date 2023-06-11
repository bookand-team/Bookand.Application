import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'error_report_model.freezed.dart';

@freezed
class ErrorReportModel with _$ErrorReportModel {
  const factory ErrorReportModel({
    required String errorDate,
    required String errorContent,
    required String email,
    required List<File> images,
    required String imageSize,
    required File? logZip,
    required bool sendLog,
    required bool termsAgree,
    required bool isLoading,
    required bool showErrorMessage,
  }) = _ErrorReportModel;
}
