import 'package:bookand/domain/model/member/member_model.dart';
import 'package:bookand/domain/model/result_response.dart';

abstract class MemberRemoteDataSource {
  Future<MemberModel> getMe(String accessToken);

  Future<String> getRandomNickname();

  Future<MemberModel> updateMemberProfile(
    String accessToken,
    String nickname,
  );

  Future<ResultResponse> deleteMember(String accessToken);
}
