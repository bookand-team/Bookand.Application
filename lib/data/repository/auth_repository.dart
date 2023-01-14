import 'dart:async';
import 'dart:io';

import 'package:bookand/config/app_config.dart';
import 'package:bookand/data/model/user_model.dart';
import 'package:bookand/provider/dio_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/const/social_type.dart';
import '../../common/const/storage_key.dart';
import '../../provider/secure_storage_provider.dart';
import '../model/token.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final dio = ref.watch(dioProvider);

  return AuthRepository(baseUrl: AppConfig.instance.baseUrl, dio: dio, ref: ref);
});

class AuthRepository {
  final String baseUrl;
  final Dio dio;
  final Ref ref;

  AuthRepository({required this.baseUrl, required this.dio, required this.ref});

  Future<Token> fetchLogin(
      {required String accessToken, required SocialType socialType}) async {
    final resp = await dio.post('$baseUrl/api/v1/auth/login',
        data: {'accessToken': accessToken, 'socialType': socialType.type});

    final respData = Token.fromJson(resp.data);
    return respData;
  }

  Future<void> refreshToken() async {
    final accessToken = await ref.read(secureStorageProvider).read(key: accessTokenKey);
    final refreshToken = await ref.read(secureStorageProvider).read(key: refreshTokenKey);

    final resp = await dio.post('$baseUrl/api/v1/auth/reissue',
        data: {'refreshToken': refreshToken},
        options: Options(headers: {'Authorization': 'BEARER $accessToken'}));

    final token = Token.fromJson(resp.data);

    ref.read(secureStorageProvider).write(key: accessTokenKey, value: token.accessToken);
    ref.read(secureStorageProvider).write(key: refreshTokenKey, value: token.refreshToken);
  }

  void logout(String accessToken) async {
    await dio.get('$baseUrl/api/v1/auth/logout',
        options: Options(headers: {'Authorization': 'BEARER $accessToken'}));
  }
}
