import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'error_report_provider.freezed.dart';

part 'error_report_provider.g.dart';

@freezed
class ErrorReportState with _$ErrorReportState {
  const factory ErrorReportState({
    required String errorDate,
    required String errorContent,
    required String email,
    required List<File> images,
    required String imageSize,
    required File? logZip,
    required bool sendLog,
    required bool termsAgree,
    required bool isLoading,
  }) = _ErrorReportState;
}

@riverpod
class ErrorReportNotifier extends _$ErrorReportNotifier {
  @override
  ErrorReportState build() => const ErrorReportState(
      errorDate: '',
      errorContent: '',
      email: '',
      images: [],
      imageSize: '0.00',
      logZip: null,
      sendLog: false,
      termsAgree: false,
      isLoading: false);

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
}
