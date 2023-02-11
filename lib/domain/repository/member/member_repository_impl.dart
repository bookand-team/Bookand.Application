import 'package:bookand/domain/model/member_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../data/datasource/remote/member/member_remote_data_source.dart';
import '../../../data/datasource/remote/member/member_remote_data_source_impl.dart';
import 'member_repository.dart';

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
    final memberEntity = await memberRemoteDataSource.getMe(accessToken);

    return MemberModel(
        id: memberEntity.id, email: memberEntity.email, nickname: memberEntity.nickname);
  }

  @override
  Future<MemberModel> updateMemberProfile(String accessToken, String nickname) async {
    final memberEntity = await memberRemoteDataSource.updateMemberProfile(accessToken, nickname);

    return MemberModel(
        id: memberEntity.id, email: memberEntity.email, nickname: memberEntity.nickname);
  }
}
