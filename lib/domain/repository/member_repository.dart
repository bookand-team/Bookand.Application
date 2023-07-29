import '../../core/const/revoke_type.dart';
import '../model/member/member_model.dart';

abstract interface class MemberRepository {
  Future<MemberModel> getMe();

  Future<String> getRandomNickname();

  Future<void> updateMemberProfile(String profileImage, String nickname);

  Future<String> revoke(String socialAccessToken, RevokeType revokeType, String? reason);
}
