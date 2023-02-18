// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'policy_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations, unnecessary_brace_in_string_interps
class _$PolicyService extends PolicyService {
  _$PolicyService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = PolicyService;

  @override
  Future<Response<dynamic>> getPolicy(String policyName) {
    final Uri $url = Uri.parse('/api/v1/policys/${policyName}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }
}
