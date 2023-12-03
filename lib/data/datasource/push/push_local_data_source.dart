abstract interface class PushLocalDataSource {
  Future<void> setEnabledPush(bool enabled);

  Future<bool> isEnabledPush();
}
