import 'dart:async';

import 'package:chopper/chopper.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../api_helper.dart';

part 'notification_service.g.dart';

part 'notification_service.chopper.dart';

@riverpod
NotificationService notificationService(NotificationServiceRef ref) =>
    NotificationService.create(ApiHelper.client());

@ChopperApi(baseUrl: '/api/v1/notifications')
abstract class NotificationService extends ChopperService {
  static NotificationService create([ChopperClient? client]) => _$NotificationService(client);

  @Get(path: '')
  Future<Response> getNotificationList(
    @Header('Authorization') String accessToken,
    @Query('cursorId') int cursorId,
    @Query('size') int size,
  );

  @Get(path: '/{notificationId}')
  Future<Response> getNotificationDetail(
      @Header('Authorization') String accessToken, @Path('notificationId') int notificationId);
}
