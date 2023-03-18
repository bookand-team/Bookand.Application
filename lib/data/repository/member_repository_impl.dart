import 'package:bookand/core/const/revoke_type.dart';
import 'package:bookand/domain/model/member/member_model.dart';
import 'package:bookand/domain/model/member/revoke_reason_request.dart';
import 'package:chopper/chopper.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/util/utf8_util.dart';
import '../../domain/model/error_response.dart';
import '../../domain/repository/member_repository.dart';
import '../datasource/member/member_remote_data_source.dart';
import '../datasource/member/member_remote_data_source_impl.dart';

part 'member_repository_impl.g.dart';

@riverpod
MemberRepository memberRepository(MemberRepositoryRef ref) {
  final memberRemoteDataSource = ref.read(memberRemoteDataSourceProvider);

  return MemberRepositoryImpl(memberRemoteDataSource);
}

class MemberRepositoryImpl implements MemberRepository {
  final MemberRemoteDataSource memberRemoteDataSource;

  MemberRepositoryImpl(this.memberRemoteDataSource);

  @override
  Future<String> getRandomNickname() async {
    try {
      return await memberRemoteDataSource.getRandomNickname();
    } on Response catch (e) {
      throw ErrorResponse.fromJson(Utf8Util.utf8JsonDecode(e.bodyString));
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<String> revoke(
      String accessToken, String socialAccessToken, RevokeType revokeType, String? reason) async {
    try {
      final requestModel = RevokeReasonRequest(reason, revokeType, socialAccessToken);
      final resultResp = await memberRemoteDataSource.revoke(accessToken, requestModel);
      return resultResp.result;
    } on Response catch (e) {
      throw ErrorResponse.fromJson(Utf8Util.utf8JsonDecode(e.bodyString));
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<MemberModel> getMe(String accessToken) async {
    try {
      return await memberRemoteDataSource.getMe(accessToken);
    } on Response catch (e) {
      throw ErrorResponse.fromJson(Utf8Util.utf8JsonDecode(e.bodyString));
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<MemberModel> updateMemberProfile(
      String accessToken, String profileImage, String nickname) async {
    try {
      return await memberRemoteDataSource.updateMemberProfile(accessToken, profileImage, nickname);
    } on Response catch (e) {
      throw ErrorResponse.fromJson(Utf8Util.utf8JsonDecode(e.bodyString));
    } catch (_) {
      rethrow;
    }
  }
}
