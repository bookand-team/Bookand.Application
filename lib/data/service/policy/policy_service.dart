import 'package:chopper/chopper.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../api_helper.dart';

part 'policy_service.g.dart';

part 'policy_service.chopper.dart';

@riverpod
PolicyService policyService(PolicyServiceRef ref) => PolicyService.create(ApiHelper.client());

@ChopperApi(baseUrl: '/api/v1/policys')
abstract class PolicyService extends ChopperService {
  static PolicyService create([ChopperClient? client]) => _$PolicyService(client);

  @Get(path: '/{terms}')
  Future<Response> getPolicy(@Path('terms') String terms);
}
