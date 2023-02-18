import 'package:bookand/domain/model/member/member_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../domain/repository/member_repository.dart';
import 'member_remote_data_source.dart';
import 'member_remote_data_source_impl.dart';

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
  Future<String> checkNicknameDuplicate(String nickname) async {
    final resultResp = await memberRemoteDataSource.checkNicknameDuplicate(nickname);

    return resultResp.result;
  }

  @override
  Future<String> deleteMember(String accessToken) async {
    final resultResp = await memberRemoteDataSource.deleteMember(accessToken);

    return resultResp.result;
  }

  @override
  Future<MemberModel> getMe(String accessToken) async {
    return await memberRemoteDataSource.getMe(accessToken);
  }

  @override
  Future<MemberModel> updateMemberProfile(String accessToken, String nickname) async {
    return await memberRemoteDataSource.updateMemberProfile(accessToken, nickname);
  }
}
