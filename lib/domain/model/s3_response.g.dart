// GENERATED CODE - DO NOT MODIFY BY HAND

part of 's3_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

S3Response _$S3ResponseFromJson(Map<String, dynamic> json) => S3Response(
      (json['files'] as List<dynamic>)
          .map((e) => FileResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$S3ResponseToJson(S3Response instance) =>
    <String, dynamic>{
      'files': instance.files,
    };

FileResponse _$FileResponseFromJson(Map<String, dynamic> json) => FileResponse(
      json['fileUrl'] as String,
      json['fileName'] as String,
    );

Map<String, dynamic> _$FileResponseToJson(FileResponse instance) =>
    <String, dynamic>{
      'fileUrl': instance.fileUrl,
      'fileName': instance.fileName,
    };
