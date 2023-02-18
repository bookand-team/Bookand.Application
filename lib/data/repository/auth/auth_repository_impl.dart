

import 'package:bookand/core/const/social_type.dart';
import 'package:bookand/domain/model/auth/token_reponse.dart';
import 'package:bookand/domain/repository/auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'auth_remote_data_source.dart';
import 'auth_remote_data_source_impl.dart';

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
    return await authRemoteDataSource.login(accessToken, socialType);
  }

  @override
  Future<String> logout(String accessToken) async {
    final baseResp = await authRemoteDataSource.logout(accessToken);
    return baseResp.data;
  }

  @override
  Future<TokenResponse> signUp(String signToken) async {
    return await authRemoteDataSource.signUp(signToken);
  }
}
