import 'dart:async';

import 'package:bookand/data/datasource/remote/auth_remote_data_source.dart';
import 'package:bookand/data/model/auth/reissue_request.dart';
import 'package:bookand/data/model/auth/social_token.dart';

import '../../api/auth_api.dart';
import '../../model/auth/token_reponse.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final AuthApi api;

  AuthRemoteDataSourceImpl(this.api);

  @override
  Future<TokenResponse> login(SocialToken socialToken) async {
    final completer = Completer<TokenResponse>();

    try {
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
  Future<TokenResponse> reissue(ReissueRequest reissueRequest) async {
    final completer = Completer<TokenResponse>();

    try {
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
      final resp = await api.signUp({'signToken': signToken});
      completer.complete(resp);
    } catch (e) {
      completer.completeError(e);
    }

    return completer.future;
  }
}
