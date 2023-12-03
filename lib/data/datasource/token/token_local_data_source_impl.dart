import 'package:bookand/data/datasource/token/token_local_data_source.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/const/storage_key.dart';

part 'token_local_data_source_impl.g.dart';

@riverpod
TokenLocalDataSource tokenLocalDataSource(TokenLocalDataSourceRef ref) {
  const storage = FlutterSecureStorage();

  return TokenLocalDataSourceImpl(storage);
}

class TokenLocalDataSourceImpl implements TokenLocalDataSource {
  final FlutterSecureStorage storage;

  TokenLocalDataSourceImpl(this.storage);

  @override
  Future<String> getAccessToken() async {
    final accessToken = await storage.read(key: accessTokenKey);

    if (accessToken == null) throw ('AccessToken is null');

    return accessToken;
  }

  @override
  Future<String> getRefreshToken() async {
    final refreshToken = await storage.read(key: refreshTokenKey);

    if (refreshToken == null) throw ('RefreshToken is null');

    return refreshToken;
  }

  @override
  Future<String> getSignToken() async {
    final signToken = await storage.read(key: signTokenKey);

    if (signToken == null) throw ('SignToken is null');

    return signToken;
  }

  @override
  Future<void> setAccessToken(String accessToken) async {
    await storage.write(key: accessTokenKey, value: accessToken);
  }

  @override
  Future<void> setRefreshToken(String refreshToken) async {
    await storage.write(key: refreshTokenKey, value: refreshToken);
  }

  @override
  Future<void> setSignToken(String signToken) async {
    await storage.write(key: signTokenKey, value: signToken);
  }

  @override
  Future<void> deleteAccessToken() async {
    await storage.delete(key: accessTokenKey);
  }

  @override
  Future<void> deleteRefreshToken() async {
    await storage.delete(key: refreshTokenKey);
  }

  @override
  Future<void> deleteSignToken() async {
    await storage.delete(key: signTokenKey);
  }
}
