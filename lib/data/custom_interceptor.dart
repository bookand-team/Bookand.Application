import 'dart:io';

import 'package:bookand/provider/auth_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../common/const/storage_key.dart';
import '../common/util/logger.dart';

class CustomInterceptor extends Interceptor {
  final FlutterSecureStorage storage;
  final Ref ref;

  CustomInterceptor({required this.storage, required this.ref});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    if (options.headers['Authorization'] == 'true') {
      options.headers.remove('Authorization');

      final token = await storage.read(key: accessTokenKey);

      options.headers.addAll({'Authorization': 'BEARER $token'});
    }

    var logMsg = '[REQ] [${options.method}] ${options.uri}';

    if (kDebugMode) {
      logMsg += '\n[Authorization] ${options.headers['Authorization']}\n[BODY] ${options.data}';
    }

    logger.i(logMsg);

    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    logger.i('[RES] [${response.requestOptions.method}] ${response.requestOptions.uri}\n[BODY] ${response.data}');

    return super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    logger.e(
        '[ERR] [${err.requestOptions.method}] ${err.requestOptions.uri}\n[Status Code] ${err.response?.statusCode}\n[DATA] ${err.response?.data}');

    var accessToken = await storage.read(key: accessTokenKey);
    final refreshToken = await storage.read(key: refreshTokenKey);

    if (refreshToken == null || accessToken == null) {
      return handler.reject(err);
    }

    final dio = Dio();
    final isPathRefresh = err.requestOptions.uri.path == 'api/v1/auth/reissue';
    final isNewUser = err.requestOptions.uri.path == 'api/v1/auth/login';

    switch (err.response?.statusCode) {
      case HttpStatus.unauthorized:
        if (!isPathRefresh) {
          try {
            await ref.read(authProvider.notifier).refreshToken();

            accessToken = await storage.read(key: accessTokenKey);

            final options = err.requestOptions;
            options.headers.addAll({'Authorization': 'BEARER $accessToken'});

            final response = await dio.fetch(options);

            return handler.resolve(response);
          } on DioError catch (e) {
            ref.read(authProvider.notifier).logout();
            return handler.reject(e);
          }
        }
        break;
      case HttpStatus.notFound:
        if (isNewUser) {
          try {
            await ref.read(authProvider.notifier).signUp();
          } on DioError catch (e) {
            return handler.reject(e);
          }
        }
        break;
    }

    return handler.reject(err);
  }
}
