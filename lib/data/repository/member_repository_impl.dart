import 'package:bookand/core/const/revoke_type.dart';
import 'package:bookand/data/datasource/token/token_local_data_source.dart';
import 'package:bookand/data/datasource/token/token_local_data_source_impl.dart';
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
  final tokenLocalDataSource = ref.read(tokenLocalDataSourceProvider);
  return MemberRepositoryImpl(memberRemoteDataSource, tokenLocalDataSource);
}

class MemberRepositoryImpl implements MemberRepository {
  final MemberRemoteDataSource memberRemoteDataSource;
  final TokenLocalDataSource tokenLocalDataSource;

  MemberRepositoryImpl(this.memberRemoteDataSource, this.tokenLocalDataSource);

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
  Future<String> revoke(String socialAccessToken, RevokeType revokeType, String? reason) async {
    try {
      final accessToken = await tokenLocalDataSource.getAccessToken();
      final requestModel = RevokeReasonRequest(reason, revokeType, socialAccessToken);
      final resultResp = await memberRemoteDataSource.revoke(accessToken, requestModel);
      await Future.wait([
        tokenLocalDataSource.deleteAccessToken(),
        tokenLocalDataSource.deleteRefreshToken(),
      ]);
      return resultResp.result;
    } on Response catch (e) {
      throw ErrorResponse.fromJson(Utf8Util.utf8JsonDecode(e.bodyString));
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<MemberModel> getMe() async {
    try {
      final accessToken = await tokenLocalDataSource.getAccessToken();
      return await memberRemoteDataSource.getMe(accessToken);
    } on Response catch (e) {
      throw ErrorResponse.fromJson(Utf8Util.utf8JsonDecode(e.bodyString));
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<MemberModel> updateMemberProfile(String profileImage, String nickname) async {
    try {
      final accessToken = await tokenLocalDataSource.getAccessToken();
      return await memberRemoteDataSource.updateMemberProfile(accessToken, profileImage, nickname);
    } on Response catch (e) {
      throw ErrorResponse.fromJson(Utf8Util.utf8JsonDecode(e.bodyString));
    } catch (_) {
      rethrow;
    }
  }
}
