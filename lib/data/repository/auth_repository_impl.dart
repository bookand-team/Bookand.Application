import 'package:bookand/core/const/social_type.dart';
import 'package:bookand/core/error/user_not_found_exception.dart';
import 'package:bookand/data/datasource/token/token_local_data_source.dart';
import 'package:bookand/data/datasource/token/token_local_data_source_impl.dart';
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
  final tokenLocalDataSource = ref.read(tokenLocalDataSourceProvider);

  return AuthRepositoryImpl(authRemoteDataSource, tokenLocalDataSource);
}

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  final TokenLocalDataSource tokenLocalDataSource;

  AuthRepositoryImpl(this.authRemoteDataSource, this.tokenLocalDataSource);

  @override
  Future<void> login(String socialAccessToken, SocialType socialType) async {
    try {
      final token = await authRemoteDataSource.login(socialAccessToken, socialType);
      await tokenLocalDataSource.setAccessToken(token.accessToken);
      await tokenLocalDataSource.setRefreshToken(token.refreshToken);
    } on Response catch (e) {
      throw ErrorResponse.fromJson(Utf8Util.utf8JsonDecode(e.bodyString));
    } on UserNotFoundException catch (e) {
      await tokenLocalDataSource.setSignToken(e.signToken);
      rethrow;
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<String> logout() async {
    try {
      final accessToken = await tokenLocalDataSource.getAccessToken();
      final baseResp = await authRemoteDataSource.logout(accessToken);
      await Future.wait([
        tokenLocalDataSource.deleteAccessToken(),
        tokenLocalDataSource.deleteRefreshToken(),
      ]);
      return baseResp.data;
    } on Response catch (e) {
      throw ErrorResponse.fromJson(Utf8Util.utf8JsonDecode(e.bodyString));
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> signUp() async {
    try {
      final signToken = await tokenLocalDataSource.getSignToken();
      final token = await authRemoteDataSource.signUp(signToken);
      await Future.wait([
        tokenLocalDataSource.setAccessToken(token.accessToken),
        tokenLocalDataSource.setRefreshToken(token.refreshToken),
        tokenLocalDataSource.deleteSignToken(),
      ]);
    } on Response catch (e) {
      throw ErrorResponse.fromJson(Utf8Util.utf8JsonDecode(e.bodyString));
    } catch (_) {
      rethrow;
    }
  }
}
