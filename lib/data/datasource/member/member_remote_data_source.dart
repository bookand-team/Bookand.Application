import 'package:bookand/domain/model/member/member_model.dart';
import 'package:bookand/domain/model/member/revoke_reason_request.dart';
import 'package:bookand/domain/model/result_response.dart';

abstract interface class MemberRemoteDataSource {
  Future<MemberModel> getMe(String accessToken);

  Future<String> getRandomNickname();

  Future<MemberModel> updateMemberProfile(
    String accessToken,
    String profileImage,
    String nickname,
  );

  Future<ResultResponse> revoke(String accessToken, RevokeReasonRequest revokeReasonRequest);
}
