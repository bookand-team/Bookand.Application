// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations, unnecessary_brace_in_string_interps
class _$MemberService extends MemberService {
  _$MemberService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = MemberService;

  @override
  Future<Response<dynamic>> checkNicknameDuplicate(String nickname) {
    final Uri $url = Uri.parse('/api/v1/members/nickname/${nickname}/check');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getMe(String accessToken) {
    final Uri $url = Uri.parse('/api/v1/members/me');
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
  Future<Response<dynamic>> updateMemberProfile(
    String accessToken,
    Map<String, dynamic> body,
  ) {
    final Uri $url = Uri.parse('/api/v1/members/remove');
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

  @override
  Future<Response<dynamic>> deleteMember(String accessToken) {
    final Uri $url = Uri.parse('/api/v1/members/remove');
    final Map<String, String> $headers = {
      'Authorization': accessToken,
    };
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<dynamic, dynamic>($request);
  }
}
