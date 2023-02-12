import 'package:bookand/data/entity/policy_entity.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/config/app_config.dart';
import '../api_helper.dart';

part 'policy_api.g.dart';

@riverpod
PolicyApi policyApi(PolicyApiRef ref) => PolicyApi(ApiHelper.create(), baseUrl: AppConfig.instance.baseUrl);

@RestApi()
abstract class PolicyApi {
  factory PolicyApi(Dio dio, {String baseUrl}) = _PolicyApi;

  @GET('/api/v1/policys/{terms}')
  Future<PolicyEntity> getPolicy(@Path('terms') String terms);
}
