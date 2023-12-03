abstract interface class TokenLocalDataSource {
  Future<void> setSignToken(String signToken);

  Future<void> setAccessToken(String accessToken);

  Future<void> setRefreshToken(String refreshToken);

  Future<String> getSignToken();

  Future<String> getAccessToken();

  Future<String> getRefreshToken();

  Future<void> deleteSignToken();

  Future<void> deleteAccessToken();

  Future<void> deleteRefreshToken();
}
