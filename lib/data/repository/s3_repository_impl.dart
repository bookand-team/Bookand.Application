import 'dart:io';

import 'package:bookand/data/datasource/s3/s3_remote_data_source.dart';
import 'package:bookand/data/datasource/s3/s3_remote_data_source_impl.dart';
import 'package:bookand/data/datasource/token/token_local_data_source.dart';
import 'package:bookand/data/datasource/token/token_local_data_source_impl.dart';
import 'package:bookand/domain/model/s3_response.dart';
import 'package:bookand/domain/repository/s3_repository.dart';
import 'package:chopper/chopper.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/util/utf8_util.dart';
import '../../domain/model/error_response.dart';

part 's3_repository_impl.g.dart';

@riverpod
S3Repository s3repository(S3repositoryRef ref) {
  final s3RemoteDataSource = ref.read(s3RemoteDataSourceProvider);
  final tokenLocalDataSource = ref.read(tokenLocalDataSourceProvider);

  return S3RepositoryImpl(s3RemoteDataSource, tokenLocalDataSource);
}

class S3RepositoryImpl implements S3Repository {
  final S3RemoteDataSource s3remoteDataSource;
  final TokenLocalDataSource tokenLocalDataSource;

  S3RepositoryImpl(this.s3remoteDataSource, this.tokenLocalDataSource);

  @override
  Future<S3Response> uploadFiles(List<File> files) async {
    try {
      final accessToken = await tokenLocalDataSource.getAccessToken();
      return await s3remoteDataSource.uploadFiles(accessToken, files);
    } on Response catch (e) {
      throw ErrorResponse.fromJson(Utf8Util.utf8JsonDecode(e.bodyString));
    } catch (_) {
      rethrow;
    }
  }
}
