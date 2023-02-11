import '../../../entity/member/member_entity.dart';
import '../../../entity/result_response.dart';

abstract class MemberRemoteDataSource {
  Future<MemberEntity> getMe(String accessToken);

  Future<ResultResponse> checkNicknameDuplicate(String nickname);

  Future<MemberEntity> updateMemberProfile(
    String accessToken,
    String nickname,
  );

  Future<ResultResponse> deleteMember(String accessToken);
}
