import 'dart:io';

import 'package:bookand/core/const/storage_key.dart';
import 'package:bookand/data/repository/s3_repository_impl.dart';
import 'package:bookand/domain/model/s3_response.dart';
import 'package:bookand/domain/repository/s3_repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/util/logger.dart';

part 'upload_files_use_case.g.dart';

@riverpod
UploadFilesUseCase uploadFilesUseCase(UploadFilesUseCaseRef ref) {
  final s3Repository = ref.read(s3repositoryProvider);
  const storage = FlutterSecureStorage();

  return UploadFilesUseCase(s3Repository, storage);
}

class UploadFilesUseCase {
  final S3Repository s3Repository;
  final FlutterSecureStorage storage;

  UploadFilesUseCase(this.s3Repository, this.storage);

  Future<List<FileResponse>> uploadFiles(List<File> files) async {
    try {
      final s3Response = await s3Repository.uploadFiles(files);
      return s3Response.files;
    } catch (e, stack) {
      logger.e(e, e, stack);
      rethrow;
    }
  }
}
