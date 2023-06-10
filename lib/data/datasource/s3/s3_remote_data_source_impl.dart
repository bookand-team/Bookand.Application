import 'dart:convert';
import 'dart:io';

import 'package:bookand/core/config/app_config.dart';
import 'package:bookand/data/datasource/s3/s3_remote_data_source.dart';
import 'package:bookand/domain/model/s3_response.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/util/logger.dart';
import '../../../core/util/utf8_util.dart';
import '../../../domain/model/error_response.dart';

part 's3_remote_data_source_impl.g.dart';

@riverpod
S3RemoteDataSource s3RemoteDataSource(S3RemoteDataSourceRef ref) => S3RemoteDataSourceImpl();

class S3RemoteDataSourceImpl implements S3RemoteDataSource {
  @override
  Future<S3Response> uploadFiles(String accessToken, List<File> files) async {
    final request =
        http.MultipartRequest("POST", Uri.parse('${AppConfig.instance.baseUrl}/api/v1/files'));

    for (var file in files) {
      request.files.add(await http.MultipartFile.fromPath('files', file.path));
    }

    request.fields.addAll({'type': 'profile'});
    request.headers.addAll({'Authorization': 'Bearer $accessToken'});

    final resp = await request.send();
    final bodyBytes = await resp.stream.single;
    final bodyString = Utf8Util.decode(bodyBytes);
    logger.i('[${resp.statusCode}] $bodyString');

    if (resp.statusCode == HttpStatus.ok) {
      return S3Response.fromJson(jsonDecode(bodyString));
    } else {
      throw ErrorResponse.fromJson(Utf8Util.utf8JsonDecode(bodyString));
    }
  }
}
