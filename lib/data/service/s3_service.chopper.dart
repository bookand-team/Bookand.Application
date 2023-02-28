// GENERATED CODE - DO NOT MODIFY BY HAND

part of 's3_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations, unnecessary_brace_in_string_interps
class _$S3Service extends S3Service {
  _$S3Service([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = S3Service;

  @override
  Future<Response<dynamic>> uploadFiles(
    String type,
    List<String> files,
  ) {
    final Uri $url = Uri.parse('/api/v1/files');
    final Map<String, String> $headers = {
      'Content-Type': 'multipart/form-data',
    };
    final $body = <String, dynamic>{'type': type};
    final List<PartValue> $parts = <PartValue>[
      PartValueFile<List<String>>(
        'files',
        files,
      )
    ];
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      parts: $parts,
      multipart: true,
      headers: $headers,
    );
    return client.send<dynamic, dynamic>($request);
  }
}
