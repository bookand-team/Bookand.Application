import 'package:bookand/core/const/social_type.dart';
import 'package:bookand/domain/model/auth/token_reponse.dart';
import 'package:bookand/domain/repository/auth_repository.dart';
import 'package:chopper/chopper.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/util/utf8_util.dart';
import '../../domain/model/error_response.dart';
import '../datasource/auth/auth_remote_data_source.dart';
import '../datasource/auth/auth_remote_data_source_impl.dart';

part 'auth_repository_impl.g.dart';

@riverpod
AuthRepository authRepository(AuthRepositoryRef ref) {
  final authRemoteDataSource = ref.read(authRemoteDataSourceProvider);

  return AuthRepositoryImpl(authRemoteDataSource);
}

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepositoryImpl(this.authRemoteDataSource);

  @override
  Future<TokenResponse> login(String accessToken, SocialType socialType) async {
    try {
      return await authRemoteDataSource.login(accessToken, socialType);
    } on Response catch (e) {
      throw ErrorResponse.fromJson(Utf8Util.utf8JsonDecode(e.bodyString));
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<String> logout(String accessToken) async {
    try {
      final baseResp = await authRemoteDataSource.logout(accessToken);
      return baseResp.data;
    } on Response catch (e) {
      throw ErrorResponse.fromJson(Utf8Util.utf8JsonDecode(e.bodyString));
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<TokenResponse> signUp(String signToken) async {
    try {
      return await authRemoteDataSource.signUp(signToken);
    } on Response catch (e) {
      throw ErrorResponse.fromJson(Utf8Util.utf8JsonDecode(e.bodyString));
    } catch (_) {
      rethrow;
    }
  }
}
