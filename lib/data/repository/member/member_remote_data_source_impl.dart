import 'dart:async';
import 'dart:convert';

import 'package:bookand/domain/model/member/member_model.dart';
import 'package:bookand/domain/model/member/member_profile_update.dart';
import 'package:bookand/domain/model/result_response.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../service/member_service.dart';
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

    if (resp.isSuccessful) {
      return ResultResponse.fromJson(jsonDecode(resp.bodyString));
    } else {
      throw resp;
    }
  }

  @override
  Future<ResultResponse> deleteMember(String accessToken) async {
    final resp = await service.deleteMember(accessToken);

    if (resp.isSuccessful) {
      return ResultResponse.fromJson(jsonDecode(resp.bodyString));
    } else {
      throw resp;
    }
  }

  @override
  Future<MemberModel> getMe(String accessToken) async {
    final resp = await service.getMe(accessToken);

    if (resp.isSuccessful) {
      return MemberModel.fromJson(jsonDecode(resp.bodyString));
    } else {
      throw resp;
    }
  }

  @override
  Future<MemberModel> updateMemberProfile(
    String accessToken,
    String nickname,
  ) async {
    final memberProfileUpdate = MemberProfileUpdate(nickname);
    final resp = await service.updateMemberProfile(accessToken, memberProfileUpdate.toJson());

    if (resp.isSuccessful) {
      return MemberModel.fromJson(jsonDecode(resp.bodyString));
    } else {
      throw resp;
    }
  }
}
