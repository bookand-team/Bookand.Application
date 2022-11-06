import 'dart:io';

import 'package:bookand/data/model/token_response.dart';
import 'package:bookand/provider/auth_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../config/app_config.dart';
import '../const/storage_key.dart';
import '../util/logger.dart';

class CustomInterceptor extends Interceptor {
  final FlutterSecureStorage storage;
  final Ref ref;

  CustomInterceptor({required this.storage, required this.ref});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    logger.i('[REQ] [${options.method}] ${options.uri}');
    logger.d(options.data);

    if (options.headers['accessToken'] == 'true') {
      options.headers.remove('accessToken');

      final token = await storage.read(key: accessTokenKey);

      options.headers.addAll({'accessToken': token});
    }

    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    logger.i('[RES] [${response.requestOptions.method}] ${response.requestOptions.uri}');

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
            options: Options(headers: {'accessToken': accessToken}));

        final token = TokenResponse.fromJson(resp.data['data']);
        final options = err.requestOptions;
        options.headers.addAll({'accessToken': token.accessToken});

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
