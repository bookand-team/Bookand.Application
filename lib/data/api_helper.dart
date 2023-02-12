import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../core/config/app_config.dart';
import '../core/const/storage_key.dart';
import '../core/util/logger.dart';
import 'api/auth_api.dart';
import 'entity/auth/reissue_request.dart';

class ApiHelper {
  static Dio create() {
    final dio = Dio();

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: _onRequest,
      onResponse: _onResponse,
      onError: (err, handler) => _onError(dio, err, handler),
    ));

    return dio;
  }

  static void _onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    logger.i('[REQ] [${options.method}] ${options.uri}');

    if (options.headers.containsKey('Authorization')) {
      final authorization = options.headers['Authorization'];
      options.headers['Authorization'] = 'Bearer $authorization';
    }

    return handler.next(options);
  }

  static void _onResponse(Response<dynamic> response, ResponseInterceptorHandler handler) {
    logger.i('[RESP] [${response.requestOptions.method}] ${response.requestOptions.uri}');

    return handler.next(response);
  }

  static void _onError(Dio dio, DioError err, ErrorInterceptorHandler handler) async {
    logger.e(
        '[ERR] [${err.requestOptions.method}] ${err.requestOptions.uri}\n[Status Code] ${err.response?.statusCode}\n[Body] ${err.response?.data}');

    final isPathRefresh = err.requestOptions.uri.path == '/api/v1/auth/reissue';

    if (err.response?.statusCode == HttpStatus.unauthorized && !isPathRefresh) {
      try {
        await _reissueToken(dio);

        const storage = FlutterSecureStorage();
        final accessToken = await storage.read(key: accessTokenKey);
        err.requestOptions.headers['Authorization'] = accessToken;

        final response = await dio.request(
          err.requestOptions.path,
          data: err.requestOptions.data,
          queryParameters: err.requestOptions.queryParameters,
          options: Options(
            method: err.requestOptions.method,
            headers: err.requestOptions.headers,
          ),
        );

        return handler.resolve(response);
      } on DioError catch (e) {
        return handler.next(e);
      }
    }

    return handler.next(err);
  }

  static Future<void> _reissueToken(Dio dio) async {
    const storage = FlutterSecureStorage();
    final refreshToken = await storage.read(key: refreshTokenKey);
    final resp = await AuthApi(dio, baseUrl: AppConfig.instance.baseUrl)
        .reissue(ReissueRequest(refreshToken!));

    await storage.write(key: accessTokenKey, value: resp.accessToken);
    await storage.write(key: refreshTokenKey, value: resp.refreshToken);
  }
}
