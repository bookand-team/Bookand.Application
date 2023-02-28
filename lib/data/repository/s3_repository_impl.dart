import 'dart:io';

import 'package:bookand/data/datasource/s3/s3_remote_data_source.dart';
import 'package:bookand/data/datasource/s3/s3_remote_data_source_impl.dart';
import 'package:bookand/domain/model/s3_response.dart';
import 'package:bookand/domain/repository/s3_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 's3_repository_impl.g.dart';

@riverpod
S3Repository s3repository(S3repositoryRef ref) {
  final s3RemoteDataSource = ref.read(s3RemoteDataSourceProvider);

  return S3RepositoryImpl(s3RemoteDataSource);
}

class S3RepositoryImpl implements S3Repository {
  final S3RemoteDataSource s3remoteDataSource;

  S3RepositoryImpl(this.s3remoteDataSource);

  @override
  Future<S3Response> uploadFiles(String accessToken, List<File> files) async {
    return await s3remoteDataSource.uploadFiles(accessToken, files);
  }
}
