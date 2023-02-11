import 'dart:async';

import 'package:bookand/data/entity/member/member_entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../api/member_api.dart';
import '../../../entity/member/member_profile_update.dart';
import '../../../entity/result_response.dart';
import 'member_remote_data_source.dart';

part 'member_remote_data_source_impl.g.dart';

@riverpod
MemberRemoteDataSource memberRemoteDataSource(MemberRemoteDataSourceRef ref) {
  final memberApi = ref.read(memberApiProvider);

  return MemberRemoteDataSourceImpl(memberApi);
}

class MemberRemoteDataSourceImpl implements MemberRemoteDataSource {
  final MemberApi api;

  MemberRemoteDataSourceImpl(this.api);

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
  Future<MemberEntity> getMe(String accessToken) async {
    final completer = Completer<MemberEntity>();

    try {
      final resp = await api.getMe(accessToken);
      completer.complete(resp);
    } catch (e) {
      completer.completeError(e);
    }

    return completer.future;
  }

  @override
  Future<MemberEntity> updateMemberProfile(
    String accessToken,
    String nickname,
  ) async {
    final completer = Completer<MemberEntity>();

    try {
      final memberProfileUpdate = MemberProfileUpdate(nickname);
      final resp = await api.updateMemberProfile(accessToken, memberProfileUpdate);
      completer.complete(resp);
    } catch (e) {
      completer.completeError(e);
    }

    return completer.future;
  }
}
