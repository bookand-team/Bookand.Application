import 'dart:async';

import 'package:bookand/domain/model/member/member_model.dart';
import 'package:bookand/domain/model/member/member_profile_update.dart';
import 'package:bookand/domain/model/member/revoke_reason_request.dart';
import 'package:bookand/domain/model/result_response.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/util/utf8_util.dart';
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
  Future<String> getRandomNickname() async {
    final resp = await service.getRandomNickname();

    if (resp.isSuccessful) {
      final jsonData = Utf8Util.utf8JsonDecode(resp.bodyString);
      return jsonData['nickname'];
    } else {
      throw resp;
    }
  }

  @override
  Future<ResultResponse> revoke(String accessToken, RevokeReasonRequest revokeReasonRequest) async {
    final resp = await service.revoke(accessToken, revokeReasonRequest.toJson());

    if (resp.isSuccessful) {
      return ResultResponse.fromJson(Utf8Util.utf8JsonDecode(resp.bodyString));
    } else {
      throw resp;
    }
  }

  @override
  Future<MemberModel> getMe(String accessToken) async {
    final resp = await service.getMe(accessToken);

    if (resp.isSuccessful) {
      return MemberModel.fromJson(Utf8Util.utf8JsonDecode(resp.bodyString));
    } else {
      throw resp;
    }
  }

  @override
  Future<void> updateMemberProfile(
    String accessToken,
    String profileImage,
    String nickname,
  ) async {
    final memberProfileUpdate = MemberProfileUpdate(profileImage, nickname);
    final resp = await service.updateMemberProfile(accessToken, memberProfileUpdate.toJson());

    if (!resp.isSuccessful) {
      throw resp;
    }
  }
}
