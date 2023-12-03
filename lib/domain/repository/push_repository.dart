abstract interface class PushRepository {
  Future<void> setEnabledPush(bool enabled);
  Future<bool> isEnabledPush();
}