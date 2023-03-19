import 'dart:async';
import 'dart:io';

import 'package:bookand/core/const/storage_key.dart';
import 'package:bookand/data/service/auth_service.dart';
import 'package:bookand/domain/model/auth/reissue_request.dart';
import 'package:bookand/domain/model/auth/token_reponse.dart';
import 'package:chopper/chopper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../core/config/app_config.dart';
import '../core/util/logger.dart';
import '../core/util/utf8_util.dart';

class ApiHelper {
  static ChopperClient client({String? baseUrl, Converter? converter}) {
    final chopper = ChopperClient(
        baseUrl: Uri.parse(baseUrl ?? AppConfig.instance.baseUrl),
        interceptors: [
          onRequest,
          onResponse,
        ],
        authenticator: JwtAuthenticator(),
        converter: converter ?? const JsonConverter(),
        errorConverter: const JsonConverter());

    return chopper;
  }

  static FutureOr<Request> onRequest(Request request) async {
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

  static FutureOr<Response> onResponse(Response response) async {
    var logTxt =
        '[RESP] [${response.base.request?.method}] [${response.statusCode}] ${response.base.request?.url}';

    if (kDebugMode) {
      logTxt += '\n[Body] ${Utf8Util.utf8JsonDecode(response.bodyString)}';
    }

    logger.i(logTxt);

    return response;
  }
}

class JwtAuthenticator extends Authenticator {
  @override
  FutureOr<Request?> authenticate(Request request, Response response,
      [Request? originalRequest]) async {
    const storage = FlutterSecureStorage();

    final isPathRefresh = request.uri.path == '/api/v1/auth/reissue';
    if (response.statusCode == HttpStatus.unauthorized && !isPathRefresh) {
      final refreshToken = await storage.read(key: refreshTokenKey);
      final reissueRequest = ReissueRequest(refreshToken!);

      final resp = await AuthService.create(ApiHelper.client()).reissue(reissueRequest.toJson());
      if (resp.statusCode != HttpStatus.ok) {
        throw (Utf8Util.decode(resp.bodyBytes));
      }

      final token = TokenResponse.fromJson(Utf8Util.utf8JsonDecode(resp.bodyString));
      await Future.wait([
        storage.write(key: accessTokenKey, value: token.accessToken),
        storage.write(key: refreshTokenKey, value: token.refreshToken),
      ]);
      request.headers['Authorization'] = token.accessToken;

      return request;
    }

    return null;
  }
}
