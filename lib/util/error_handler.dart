class BaseError {
  final Object value;
  final String message;

  BaseError({required this.value, required this.message});
}

mixin ErrorHandler {
  Future<void> futureError(BaseError error) {
    return Future.error(error);
  }
}
