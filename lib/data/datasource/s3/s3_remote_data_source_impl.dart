import 'dart:convert';
import 'dart:io';

import 'package:bookand/core/config/app_config.dart';
import 'package:bookand/data/datasource/s3/s3_remote_data_source.dart';
import 'package:bookand/domain/model/s3_response.dart';
import 'package:chopper/chopper.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:http/http.dart' as http;

import '../../service/s3_service.dart';

part 's3_remote_data_source_impl.g.dart';

@riverpod
S3RemoteDataSource s3RemoteDataSource(S3RemoteDataSourceRef ref) {
  final s3Service = ref.read(s3ServiceProvider);

  return S3RemoteDataSourceImpl(s3Service);
}

class S3RemoteDataSourceImpl implements S3RemoteDataSource {
  final S3Service service;

  S3RemoteDataSourceImpl(this.service);

  @override
  Future<S3Response> uploadFiles(List<File> files) async {
    final request =
        http.MultipartRequest("POST", Uri.parse('${AppConfig.instance.baseUrl}/api/v1/files'));
    for (var file in files) {
      request.files.add(await http.MultipartFile.fromPath('files', file.path));
    }
    final resp = await service.uploadFiles('profile', [files[0].path]);

    if (resp.isSuccessful) {
      return S3Response.fromJson(jsonDecode(resp.bodyString));
    } else {
      throw resp;
    }
  }
}
