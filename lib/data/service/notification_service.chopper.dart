// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations, unnecessary_brace_in_string_interps
class _$NotificationService extends NotificationService {
  _$NotificationService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = NotificationService;

  @override
  Future<Response<dynamic>> getNotificationList(
    String accessToken,
    int page,
  ) {
    final Uri $url = Uri.parse('/api/v1/notifications');
    final Map<String, dynamic> $params = <String, dynamic>{'page': page};
    final Map<String, String> $headers = {
      'Authorization': accessToken,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      headers: $headers,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getNotificationDetail(
    String accessToken,
    int notificationId,
  ) {
    final Uri $url = Uri.parse('/api/v1/notifications/${notificationId}');
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
}
