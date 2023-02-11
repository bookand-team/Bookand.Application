import 'package:bookand/data/model/member/member_profile_update.dart';

import '../../model/member/member_model.dart';
import '../../model/result_response.dart';

abstract class UserRemoteDataSource {
  Future<MemberModel> getMe(String accessToken);

  Future<ResultResponse> checkNicknameDuplicate(String nickname);

  Future<MemberModel> updateMemberProfile(
    String accessToken,
    MemberProfileUpdate memberProfileUpdate,
  );

  Future<ResultResponse> deleteMember(String accessToken);
}
