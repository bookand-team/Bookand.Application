import 'package:bookand/data/api_helper.dart';
import 'package:chopper/chopper.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'member_service.g.dart';

part 'member_service.chopper.dart';

@riverpod
MemberService memberService(MemberServiceRef ref) => MemberService.create(ApiHelper.client(ref: ref));

@ChopperApi(baseUrl: '/api/v1/members')
abstract class MemberService extends ChopperService {
  static MemberService create([ChopperClient? client]) => _$MemberService(client);

  @Get(path: '/nickname/random')
  Future<Response> getRandomNickname();

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
