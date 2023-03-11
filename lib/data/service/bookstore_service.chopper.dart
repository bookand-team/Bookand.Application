// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookstore_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations, unnecessary_brace_in_string_interps
class _$BookstoreService extends BookstoreService {
  _$BookstoreService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = BookstoreService;

  @override
  Future<Response<dynamic>> bookstoreReport(
    String accessToken,
    Map<String, dynamic> body,
  ) {
    final Uri $url = Uri.parse('/api/v1/bookstores/report');
    final Map<String, String> $headers = {
      'Authorization': accessToken,
    };
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client.send<dynamic, dynamic>($request);
  }
}
