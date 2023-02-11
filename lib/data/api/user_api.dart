import 'package:bookand/data/model/member/member_profile_update.dart';
import 'package:bookand/data/model/result_response.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/http.dart';

import '../model/member/member_model.dart';

part 'user_api.g.dart';

@RestApi()
abstract class UserApi {
  factory UserApi(Dio dio, {String baseUrl}) = _UserApi;

  @GET('/api/v1/members/me')
  Future<MemberModel> getMe(@Header('Authorization') String accessToken);

  @GET('/api/v1/members/nickname/{nickname}/check')
  Future<ResultResponse> checkNicknameDuplicate(@Path('nickname') String nickname);

  @PUT('/api/v1/members/profile')
  Future<MemberModel> updateMemberProfile(
    @Header('Authorization') String accessToken,
    @Body() MemberProfileUpdate memberProfileUpdate,
  );

  @POST('/api/v1/members/remove')
  Future<ResultResponse> deleteMember(@Header('Authorization') String accessToken);
}
