import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bookand/data/service/auth_service.dart';
import 'package:bookand/domain/model/auth/reissue_request.dart';
import 'package:bookand/domain/model/auth/token_reponse.dart';
import 'package:chopper/chopper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../core/config/app_config.dart';
import '../core/const/storage_key.dart';
import '../core/util/logger.dart';

class ApiHelper {
  static ChopperClient client({String? baseUrl}) {
    final chopper = ChopperClient(
        baseUrl: Uri.parse(baseUrl ?? AppConfig.instance.baseUrl),
        interceptors: [
          _onRequest,
          _onResponse,
        ],
        authenticator: JwtAuthenticator(),
        converter: const JsonConverter(),
        errorConverter: const JsonConverter());

    return chopper;
  }

  static FutureOr<Request> _onRequest(Request request) async {
    if (request.headers.containsKey('Authorization')) {
      request.headers.update('Authorization', (authorization) => 'Bearer $authorization');
    }

    var logTxt = '[REQ] [${request.method}] ${request.url}';

    if (kDebugMode) {
      logTxt += '\n[Headers] ${request.headers}\n[Body] ${request.body}';
    }

    logger.i(logTxt);

    return request;
  }

  static FutureOr<Response> _onResponse(Response response) async {
    var logTxt =
        '[RESP] [${response.base.request?.method}] [${response.statusCode}] ${response.base.request?.url}';

    if (kDebugMode) {
      logTxt += '\n[Body] ${response.body}';
    }

    logger.i(logTxt);

    return response;
  }
}

class JwtAuthenticator extends Authenticator {
  @override
  FutureOr<Request?> authenticate(Request request, Response response,
      [Request? originalRequest]) async {
    final isPathRefresh = request.uri.path == '/api/v1/auth/reissue';

    if (response.statusCode == HttpStatus.unauthorized && !isPathRefresh) {
      const storage = FlutterSecureStorage();

      final refreshToken = await storage.read(key: refreshTokenKey);
      final reissueRequest = ReissueRequest(refreshToken!);

      final authService = AuthService.create(ApiHelper.client());
      final resp = await authService.reissue(reissueRequest.toJson());

      if (resp.statusCode != HttpStatus.ok) {
        throw ('토큰 갱신 실패');
      }

      final token = TokenResponse.fromJson(jsonDecode(resp.bodyString));

      await storage.write(key: accessTokenKey, value: token.accessToken);
      await storage.write(key: refreshTokenKey, value: token.refreshToken);

      final accessToken = await storage.read(key: accessTokenKey);
      request.headers['Authorization'] = accessToken!;

      return request;
    }

    return null;
  }
}
