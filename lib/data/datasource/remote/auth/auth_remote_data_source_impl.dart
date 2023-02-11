import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/const/social_type.dart';
import '../../../api/auth_api.dart';
import '../../../entity/auth/reissue_request.dart';
import '../../../entity/auth/sign_up_entity.dart';
import '../../../entity/auth/social_token.dart';
import '../../../entity/auth/token_reponse.dart';
import 'auth_remote_data_source.dart';

part 'auth_remote_data_source_impl.g.dart';

@riverpod
AuthRemoteDataSource authRemoteDataSource(AuthRemoteDataSourceRef ref) {
  final authApi = ref.read(authApiProvider);

  return AuthRemoteDataSourceImpl(authApi);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final AuthApi api;

  AuthRemoteDataSourceImpl(this.api);

  @override
  Future<TokenResponse> login(String accessToken, SocialType socialType) async {
    final completer = Completer<TokenResponse>();

    try {
      final socialToken = SocialToken(accessToken, socialType);
      final resp = await api.login(socialToken);
      completer.complete(resp);
    } catch (e) {
      completer.completeError(e);
    }

    return completer.future;
  }

  @override
  Future<String> logout(String accessToken) async {
    final completer = Completer<String>();

    try {
      final resp = await api.logout(accessToken);
      completer.complete(resp.data);
    } catch (e) {
      completer.completeError(e);
    }

    return completer.future;
  }

  @override
  Future<TokenResponse> reissue(String refreshToken) async {
    final completer = Completer<TokenResponse>();

    try {
      final reissueRequest = ReissueRequest(refreshToken);
      final resp = await api.reissue(reissueRequest);
      completer.complete(resp);
    } catch (e) {
      completer.completeError(e);
    }

    return completer.future;
  }

  @override
  Future<TokenResponse> signUp(String signToken) async {
    final completer = Completer<TokenResponse>();

    try {
      final signUpEntity = SignUpEntity(signToken);
      final resp = await api.signUp(signUpEntity);
      completer.complete(resp);
    } catch (e) {
      completer.completeError(e);
    }

    return completer.future;
  }
}
