class UserNotFoundException implements Exception {
  final String signToken;
  final String message;

  UserNotFoundException({
    required this.signToken,
    required this.message,
  });
}
