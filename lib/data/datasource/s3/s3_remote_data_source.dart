import 'dart:io';

import 'package:bookand/domain/model/s3_response.dart';

abstract class S3RemoteDataSource {
  Future<S3Response> uploadFiles(List<File> files);
}
