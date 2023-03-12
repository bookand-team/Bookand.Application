import 'package:bookand/data/api_helper.dart';
import 'package:chopper/chopper.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_service.g.dart';

part 'auth_service.chopper.dart';

@riverpod
AuthService authService(AuthServiceRef ref) => AuthService.create(ApiHelper.client(ref: ref));

@ChopperApi(baseUrl: '/api/v1/auth')
abstract class AuthService extends ChopperService {
  static AuthService create([ChopperClient? client]) => _$AuthService(client);

  @Post(path: '/login')
  Future<Response> login(@Body() Map<String, dynamic> body);

  @Get(path: '/logout')
  Future<Response> logout(@Header('Authorization') String accessToken);

  @Post(path: '/signup')
  Future<Response> signUp(@Body() Map<String, dynamic> body);

  @Post(path: '/reissue')
  Future<Response> reissue(@Body() Map<String, dynamic> body);
}
