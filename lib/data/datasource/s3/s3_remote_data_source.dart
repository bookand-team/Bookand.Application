import 'dart:io';

import 'package:bookand/domain/model/s3_response.dart';

abstract interface class S3RemoteDataSource {
  Future<S3Response> uploadFiles(String accessToken, List<File> files);
}
