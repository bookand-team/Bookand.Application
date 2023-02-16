import 'dart:async';
import 'dart:convert';

import 'package:bookand/data/entity/member/member_entity.dart';
import 'package:bookand/data/service/member/member_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../entity/member/member_profile_update.dart';
import '../../../entity/result_response.dart';
import 'member_remote_data_source.dart';

part 'member_remote_data_source_impl.g.dart';

@riverpod
MemberRemoteDataSource memberRemoteDataSource(MemberRemoteDataSourceRef ref) {
  final memberService = ref.read(memberServiceProvider);

  return MemberRemoteDataSourceImpl(memberService);
}

class MemberRemoteDataSourceImpl implements MemberRemoteDataSource {
  final MemberService service;

  MemberRemoteDataSourceImpl(this.service);

  @override
  Future<ResultResponse> checkNicknameDuplicate(String nickname) async {
    final resp = await service.checkNicknameDuplicate(nickname);
    final data = ResultResponse.fromJson(jsonDecode(resp.bodyString));

    if (resp.isSuccessful) {
      return data;
    } else {
      throw resp;
    }
  }

  @override
  Future<ResultResponse> deleteMember(String accessToken) async {
    final resp = await service.deleteMember(accessToken);
    final data = ResultResponse.fromJson(jsonDecode(resp.bodyString));

    if (resp.isSuccessful) {
      return data;
    } else {
      throw resp;
    }
  }

  @override
  Future<MemberEntity> getMe(String accessToken) async {
    final resp = await service.getMe(accessToken);
    final data = MemberEntity.fromJson(jsonDecode(resp.bodyString));

    if (resp.isSuccessful) {
      return data;
    } else {
      throw resp;
    }
  }

  @override
  Future<MemberEntity> updateMemberProfile(
    String accessToken,
    String nickname,
  ) async {
    final memberProfileUpdate = MemberProfileUpdate(nickname);
    final resp = await service.updateMemberProfile(accessToken, memberProfileUpdate.toJson());
    final data = MemberEntity.fromJson(jsonDecode(resp.bodyString));

    if (resp.isSuccessful) {
      return data;
    } else {
      throw resp;
    }
  }
}
