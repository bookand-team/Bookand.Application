import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bookand/core/error/user_not_found_exception.dart';
import 'package:bookand/data/service/auth/auth_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/const/social_type.dart';
import '../../../entity/auth/sign_up_entity.dart';
import '../../../entity/auth/login_request.dart';
import '../../../entity/auth/token_reponse.dart';
import '../../../entity/base_response.dart';
import 'auth_remote_data_source.dart';

part 'auth_remote_data_source_impl.g.dart';

@riverpod
AuthRemoteDataSource authRemoteDataSource(AuthRemoteDataSourceRef ref) {
  final authService = ref.read(authServiceProvider);

  return AuthRemoteDataSourceImpl(authService);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final AuthService service;

  AuthRemoteDataSourceImpl(this.service);

  @override
  Future<TokenResponse> login(String accessToken, SocialType socialType) async {
    final loginRequest = LoginRequest(accessToken, socialType.type);
    final resp = await service.login(loginRequest.toJson());
    final jsonData = jsonDecode(resp.bodyString);

    switch (resp.statusCode) {
      case HttpStatus.ok:
        final data = TokenResponse.fromJson(jsonData);
        return data;
      case HttpStatus.notFound:
        final signToken = jsonData['signToken'];
        throw UserNotFoundException(
          signToken: signToken,
          message: '존재하지 않는 사용자',
        );
      default:
        throw resp;
    }
  }

  @override
  Future<BaseResponse<String>> logout(String accessToken) async {
    final resp = await service.logout(accessToken);
    final data =
        BaseResponse<String>.fromJson(jsonDecode(resp.bodyString), (json) => json.toString());

    if (resp.isSuccessful) {
      return data;
    } else {
      throw resp;
    }
  }

  @override
  Future<TokenResponse> signUp(String signToken) async {
    final signUpEntity = SignUpEntity(signToken);
    final resp = await service.signUp(signUpEntity.toJson());
    final data = TokenResponse.fromJson(jsonDecode(resp.bodyString));

    if (resp.isSuccessful) {
      return data;
    } else {
      throw resp;
    }
  }
}
