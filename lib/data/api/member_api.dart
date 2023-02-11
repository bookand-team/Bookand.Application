import 'package:bookand/data/entity/member/member_entity.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/http.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/config/app_config.dart';
import '../api_helper.dart';
import '../entity/member/member_profile_update.dart';
import '../entity/result_response.dart';

part 'member_api.g.dart';

@riverpod
MemberApi memberApi(MemberApiRef ref) =>
    MemberApi(ApiHelper.create(), baseUrl: AppConfig.instance.baseUrl);

@RestApi()
abstract class MemberApi {
  factory MemberApi(Dio dio, {String baseUrl}) = _MemberApi;

  @GET('/api/v1/members/me')
  Future<MemberEntity> getMe(@Header('Authorization') String accessToken);

  @GET('/api/v1/members/nickname/{nickname}/check')
  Future<ResultResponse> checkNicknameDuplicate(@Path('nickname') String nickname);

  @PUT('/api/v1/members/profile')
  Future<MemberEntity> updateMemberProfile(
    @Header('Authorization') String accessToken,
    @Body() MemberProfileUpdate memberProfileUpdate,
  );

  @POST('/api/v1/members/remove')
  Future<ResultResponse> deleteMember(@Header('Authorization') String accessToken);
}
