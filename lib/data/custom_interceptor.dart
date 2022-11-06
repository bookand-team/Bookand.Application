import 'dart:io';

import 'package:bookand/data/model/token_response.dart';
import 'package:bookand/provider/auth_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../config/app_config.dart';
import '../const/storage_key.dart';
import '../util/logger.dart';
import 'model/response_data.dart';

class CustomInterceptor extends Interceptor {
  final FlutterSecureStorage storage;
  final Ref ref;

  CustomInterceptor({required this.storage, required this.ref});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    logger.i('[REQ] [${options.method}] ${options.uri}');

    if (options.headers['Authorization'] == 'true') {
      options.headers.remove('Authorization');

      final token = await storage.read(key: accessTokenKey);

      options.headers.addAll({'Authorization': 'BEARER $token'});
    }

    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    logger.i('[RESP] [${response.requestOptions.method}] ${response.requestOptions.uri}\n[Response Data] ${response.data}');

    return super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    logger.e(
        '[ERR] [${err.requestOptions.method}] ${err.requestOptions.uri}\n[Status Code] ${err.response?.statusCode}\n[Response Data] ${err.response?.data}');

    final accessToken = await storage.read(key: accessTokenKey);
    final refreshToken = await storage.read(key: refreshTokenKey);

    if (refreshToken == null || accessToken == null) {
      return handler.reject(err);
    }

    final isStatus401 = err.response?.statusCode == HttpStatus.unauthorized;
    final isPathRefresh = err.requestOptions.path == '/auth/reissue';

    if (isStatus401 && !isPathRefresh) {
      final dio = Dio();

      try {
        final resp = await dio.post('${AppConfig.instance.baseUrl}/api/v1/auth/reissue',
            queryParameters: {'refreshToken': refreshToken},
            options: Options(headers: {'Authorization': accessToken}));

        final respData = ResponseData.fromJson(resp.data);
        final token = TokenResponse.fromJson(respData.data);
        final options = err.requestOptions;
        options.headers.addAll({'Authorization': token.accessToken});

        await storage.write(key: accessTokenKey, value: token.accessToken);

        final response = await dio.fetch(options);

        return handler.resolve(response);
      } on DioError catch (e) {
        ref.read(authProvider.notifier).logout();
        return handler.reject(e);
      }
    }

    return handler.reject(err);
  }
}
