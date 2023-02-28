import 'dart:io';

import 'package:bookand/data/api_helper.dart';
import 'package:chopper/chopper.dart';
import 'package:http/http.dart' hide Request, Response;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 's3_service.g.dart';

part 's3_service.chopper.dart';

@riverpod
S3Service s3Service(S3ServiceRef ref) => S3Service.create(ApiHelper.client());

@ChopperApi(baseUrl: '/api/v1/files')
abstract class S3Service extends ChopperService {
  static S3Service create([ChopperClient? client]) => _$S3Service(client);

  @Post(
    headers: {
      'Content-Type': 'multipart/form-data',
    },
  )
  @multipart
  Future<Response> uploadFiles(
    @Field('type') String type,
    @PartFile('files') List<String> files,
  );
}
