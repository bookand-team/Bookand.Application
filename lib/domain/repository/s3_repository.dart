import 'dart:io';

import '../model/s3_response.dart';

abstract class S3Repository {
  Future<S3Response> uploadFiles(String accessToken, List<File> files);
}
