import '../model/member/member_model.dart';

abstract class MemberRepository {
  Future<MemberModel> getMe(String accessToken);

  Future<String> getRandomNickname();

  Future<MemberModel> updateMemberProfile(String accessToken, String nickname);

  Future<String> deleteMember(String accessToken);
}
