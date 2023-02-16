import 'package:bookand/core/const/social_type.dart';
import 'package:bookand/data/datasource/remote/auth/auth_remote_data_source.dart';
import 'package:bookand/data/datasource/remote/auth/auth_remote_data_source_impl.dart';
import 'package:bookand/domain/repository/auth/auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../model/token.dart';

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
  Future<Token> login(String accessToken, SocialType socialType) async {
    final tokenResponse = await authRemoteDataSource.login(accessToken, socialType);

    return Token(
      accessToken: tokenResponse.accessToken,
      refreshToken: tokenResponse.refreshToken,
    );
  }

  @override
  Future<String> logout(String accessToken) async {
    final baseResp = await authRemoteDataSource.logout(accessToken);
    return baseResp.data;
  }

  @override
  Future<Token> signUp(String signToken) async {
    final tokenResponse = await authRemoteDataSource.signUp(signToken);

    return Token(
      accessToken: tokenResponse.accessToken,
      refreshToken: tokenResponse.refreshToken,
    );
  }
}
