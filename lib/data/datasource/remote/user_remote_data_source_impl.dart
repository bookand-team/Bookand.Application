import 'dart:async';

import 'package:bookand/data/datasource/remote/user_remote_data_source.dart';
import 'package:bookand/data/model/member/member_model.dart';
import 'package:bookand/data/model/member/member_profile_update.dart';
import 'package:bookand/data/model/result_response.dart';

import '../../api/user_api.dart';

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final UserApi api;

  UserRemoteDataSourceImpl(this.api);

  @override
  Future<ResultResponse> checkNicknameDuplicate(String nickname) async {
    final completer = Completer<ResultResponse>();

    try {
      final resp = await api.checkNicknameDuplicate(nickname);
      completer.complete(resp);
    } catch (e) {
      completer.completeError(e);
    }

    return completer.future;
  }

  @override
  Future<ResultResponse> deleteMember(String accessToken) async {
    final completer = Completer<ResultResponse>();

    try {
      final resp = await api.deleteMember(accessToken);
      completer.complete(resp);
    } catch (e) {
      completer.completeError(e);
    }

    return completer.future;
  }

  @override
  Future<MemberModel> getMe(String accessToken) async {
    final completer = Completer<MemberModel>();

    try {
      final resp = await api.getMe(accessToken);
      completer.complete(resp);
    } catch (e) {
      completer.completeError(e);
    }

    return completer.future;
  }

  @override
  Future<MemberModel> updateMemberProfile(
    String accessToken,
    MemberProfileUpdate memberProfileUpdate,
  ) async {
    final completer = Completer<MemberModel>();

    try {
      final resp = await api.updateMemberProfile(accessToken, memberProfileUpdate);
      completer.complete(resp);
    } catch (e) {
      completer.completeError(e);
    }

    return completer.future;
  }
}
