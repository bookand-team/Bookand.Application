import 'package:chopper/chopper.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../api_helper.dart';

part 'kakao_service.g.dart';

part 'kakao_service.chopper.dart';

@riverpod
KakaoService kakaoService(KakaoServiceRef ref) => KakaoService.create(ApiHelper.client());

@ChopperApi(baseUrl: '/api/v1')
abstract class KakaoService extends ChopperService {
  static KakaoService create([ChopperClient? client]) => _$KakaoService(client);

  @Get(path: '/maps/search')
  Future<Response> searchKeyword(
    @Header('Authorization') String accessToken,
    @Query('query') String query,
    @Query('page') int page,
    @Query('size') int size,
  );
}
