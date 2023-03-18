import 'dart:async';
import 'dart:io';

import 'package:bookand/data/service/auth_service.dart';
import 'package:bookand/domain/model/auth/reissue_request.dart';
import 'package:bookand/domain/model/auth/token_reponse.dart';
import 'package:bookand/presentation/provider/router_provider.dart';
import 'package:bookand/presentation/screen/login_screen.dart';
import 'package:chopper/chopper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../core/config/app_config.dart';
import '../core/const/storage_key.dart';
import '../core/util/logger.dart';
import '../core/util/utf8_util.dart';

class ApiHelper {
  static ChopperClient client({required Ref ref, String? baseUrl, Converter? converter}) {
    final chopper = ChopperClient(
        baseUrl: Uri.parse(baseUrl ?? AppConfig.instance.baseUrl),
        interceptors: [
          _onRequest,
          _onResponse,
        ],
        authenticator: JwtAuthenticator(ref, const FlutterSecureStorage()),
        converter: converter ?? const JsonConverter(),
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
      logTxt += '\n[Body] ${Utf8Util.utf8JsonDecode(response.bodyString)}';
    }

    logger.i(logTxt);

    return response;
  }
}

class JwtAuthenticator extends Authenticator {
  final Ref ref;
  final FlutterSecureStorage storage;

  JwtAuthenticator(this.ref, this.storage);

  @override
  FutureOr<Request?> authenticate(Request request, Response response,
      [Request? originalRequest]) async {
    final isPathRefresh = request.uri.path == '/api/v1/auth/reissue';

    if (response.statusCode == HttpStatus.unauthorized && !isPathRefresh) {
      final refreshToken = await storage.read(key: refreshTokenKey);
      final reissueRequest = ReissueRequest(refreshToken!);

      final resp = await ref.read(authServiceProvider).reissue(reissueRequest.toJson());

      if (resp.statusCode != HttpStatus.ok) {
        ref.read(goRouterStateNotifierProvider).goNamed(LoginScreen.routeName);
        throw ('토큰 갱신 실패');
      }

      final token = TokenResponse.fromJson(Utf8Util.utf8JsonDecode(resp.bodyString));

      await storage.write(key: accessTokenKey, value: token.accessToken);
      await storage.write(key: refreshTokenKey, value: token.refreshToken);

      final accessToken = await storage.read(key: accessTokenKey);
      request.headers['Authorization'] = accessToken!;

      return request;
    }

    return null;
  }
}
