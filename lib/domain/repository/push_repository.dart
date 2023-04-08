abstract class PushRepository {
  Future<void> setEnabledPush(bool enabled);
  Future<bool> isEnabledPush();
}