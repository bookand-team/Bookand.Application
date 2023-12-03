import 'dart:io';

import '../model/s3_response.dart';

abstract interface class S3Repository {
  Future<S3Response> uploadFiles(List<File> files);
}
