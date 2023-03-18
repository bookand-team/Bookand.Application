import '../../core/const/revoke_type.dart';
import '../model/member/member_model.dart';

abstract class MemberRepository {
  Future<MemberModel> getMe(String accessToken);

  Future<String> getRandomNickname();

  Future<MemberModel> updateMemberProfile(String accessToken, String profileImage, String nickname);

  Future<String> revoke(
      String accessToken, String socialAccessToken, RevokeType revokeType, String? reason);
}
