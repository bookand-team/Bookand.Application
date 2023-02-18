// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations, unnecessary_brace_in_string_interps
class _$AuthService extends AuthService {
  _$AuthService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = AuthService;

  @override
  Future<Response<dynamic>> login(Map<String, dynamic> body) {
    final Uri $url = Uri.parse('/api/v1/auth/login');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> logout(String accessToken) {
    final Uri $url = Uri.parse('/api/v1/auth/logout');
    final Map<String, String> $headers = {
      'Authorization': accessToken,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> signUp(Map<String, dynamic> body) {
    final Uri $url = Uri.parse('/api/v1/auth/signup');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> reissue(Map<String, dynamic> body) {
    final Uri $url = Uri.parse('/api/v1/auth/reissue');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }
}
