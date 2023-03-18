import 'dart:io';

import 'package:bookand/core/const/social_type.dart';
import 'package:bookand/core/error/user_not_found_exception.dart';
import 'package:bookand/domain/model/auth/login_request.dart';
import 'package:bookand/domain/model/auth/sign_up_entity.dart';
import 'package:bookand/domain/model/auth/token_reponse.dart';
import 'package:bookand/domain/model/base_response.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/util/utf8_util.dart';
import '../../service/auth_service.dart';
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
    final loginRequest = LoginRequest(accessToken, socialType);
    final resp = await service.login(loginRequest.toJson());

    switch (resp.statusCode) {
      case HttpStatus.ok:
        return TokenResponse.fromJson(Utf8Util.utf8JsonDecode(resp.bodyString));
      case HttpStatus.notFound:
        final jsonData = Utf8Util.utf8JsonDecode(resp.bodyString);
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

    if (resp.isSuccessful) {
      return BaseResponse<String>.fromJson(Utf8Util.utf8JsonDecode(resp.bodyString), (json) => json.toString());
    } else {
      throw resp;
    }
  }

  @override
  Future<TokenResponse> signUp(String signToken) async {
    final signUpEntity = SignUpEntity(signToken);
    final resp = await service.signUp(signUpEntity.toJson());

    if (resp.isSuccessful) {
      return TokenResponse.fromJson(Utf8Util.utf8JsonDecode(resp.bodyString));
    } else {
      throw resp;
    }
  }
}
