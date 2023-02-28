import 'package:json_annotation/json_annotation.dart';

part 's3_response.g.dart';

@JsonSerializable()
class S3Response {
  final List<FileResponse> files;

  S3Response(this.files);

  factory S3Response.fromJson(Map<String, dynamic> json) => _$S3ResponseFromJson(json);

  Map<String, dynamic> toJson() => _$S3ResponseToJson(this);
}

@JsonSerializable()
class FileResponse {
  final String fileUrl;
  final String filename;

  FileResponse(this.fileUrl, this.filename);

  factory FileResponse.fromJson(Map<String, dynamic> json) => _$FileResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FileResponseToJson(this);
}
