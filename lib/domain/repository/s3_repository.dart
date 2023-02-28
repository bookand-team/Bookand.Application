import 'dart:io';

import '../model/s3_response.dart';

abstract class S3Repository {
  Future<S3Response> uploadFiles(List<File> files);
}
