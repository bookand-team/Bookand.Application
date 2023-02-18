import 'package:chopper/chopper.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../api_helper.dart';

part 'member_service.g.dart';

part 'member_service.chopper.dart';

@riverpod
MemberService memberService(MemberServiceRef ref) => MemberService.create(ApiHelper.client());

@ChopperApi(baseUrl: '/api/v1/members')
abstract class MemberService extends ChopperService {
  static MemberService create([ChopperClient? client]) => _$MemberService(client);

  @Get(path: '/nickname/{nickname}/check')
  Future<Response> checkNicknameDuplicate(@Path('nickname') String nickname);

  @Get(path: '/me')
  Future<Response> getMe(@Header('Authorization') String accessToken);

  @Put(path: '/profile')
  Future<Response> updateMemberProfile(
    @Header('Authorization') String accessToken,
    @Body() Map<String, dynamic> body,
  );

  @Delete(path: '/remove')
  Future<Response> deleteMember(@Header('Authorization') String accessToken);
}
