import 'dart:io';

import 'package:bookand/core/extensions/string_extension.dart';
import 'package:bookand/domain/model/error_response.dart';
import 'package:bookand/domain/usecase/report_issue_use_case.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/util/logger.dart';
import '../../domain/model/error_report_model.dart';

part 'error_report_provider.g.dart';

@riverpod
class ErrorReportNotifier extends _$ErrorReportNotifier {
  @override
  ErrorReportModel build() => const ErrorReportModel(
      errorDate: '',
      errorContent: '',
      email: '',
      images: [],
      imageSize: '0.00',
      logZip: null,
      sendLog: false,
      termsAgree: false,
      isLoading: false,
      showErrorMessage: false);

  void onChangedErrorDateText(String value) {
    state = state.copyWith(errorDate: value);
  }

  void onChangedErrorContentText(String value) {
    state = state.copyWith(errorContent: value);
  }

  void onChangedEmailText(String value) {
    state = state.copyWith(email: value);
  }

  void addImage(List<XFile> images) {
    final fileList = images.map((e) => File(e.path)).toList();
    double imageSize = double.parse(state.imageSize);
    for (var e in fileList) {
      imageSize += e.lengthSync() / 1024 / 1024;
    }
    state =
        state.copyWith(images: state.images + fileList, imageSize: imageSize.toStringAsFixed(2));
  }

  void deleteImage(int index) {
    final tempImages = List.generate(state.images.length, (index) => state.images[index]);
    final removedFile = tempImages.removeAt(index);
    final removedSize = removedFile.lengthSync() / 1024 / 1024;
    final imageSize = double.parse(state.imageSize) - removedSize;
    state = state.copyWith(
      images: tempImages,
      imageSize: imageSize < 0 ? '0.00' : imageSize.toStringAsFixed(2),
    );
  }

  void onChangedSendLog(bool value) {
    state = state.copyWith(sendLog: value);
  }

  void toggleTermsAgree() {
    bool value = !state.termsAgree;
    state = state.copyWith(termsAgree: value);
  }

  Future<void> reportError({
    required Function() onSuccess,
    required Function(String) onError,
  }) async {
    if (!checkValidate()) {
      state = state.copyWith(showErrorMessage: true);
      return;
    }

    final imageSize = double.parse(state.imageSize);
    if (imageSize > 30) {
      onError("이미지 첨부는 30MB 이하까지 가능합니다.");
      return;
    }

    state = state.copyWith(isLoading: true);
    try {
      await ref.read(reportIssueUseCaseProvider).reportIssue(state);
      onSuccess();
    } on ErrorResponse catch (e) {
      onError('[${e.code}] ${e.message}');
    } catch (e, stack) {
      logger.e(e.toString(), e, stack);
      onError(e.toString());
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  bool checkValidate() {
    return checkDateFormat() &&
        state.errorContent.isNotEmpty &&
        state.email.isEmail() &&
        state.termsAgree;
  }

  bool checkDateFormat() {
    try {
      DateFormat('yyyy/MM/dd HH:mm').parse(state.errorDate);
      return true;
    } catch (_) {
      return false;
    }
  }
}
