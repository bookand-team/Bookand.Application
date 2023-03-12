import 'package:bookand/data/api_helper.dart';
import 'package:chopper/chopper.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'policy_service.g.dart';

part 'policy_service.chopper.dart';

@riverpod
PolicyService policyService(PolicyServiceRef ref) => PolicyService.create(ApiHelper.client(ref: ref));

@ChopperApi(baseUrl: '/api/v1/policys')
abstract class PolicyService extends ChopperService {
  static PolicyService create([ChopperClient? client]) => _$PolicyService(client);

  @Get(path: '/{policyName}')
  Future<Response> getPolicy(@Path('policyName') String policyName);
}
