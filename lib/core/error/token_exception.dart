import '../../domain/model/error_response.dart';

class TokenException implements Exception {
  final ErrorResponse errorResponse;

  TokenException({
    required this.errorResponse,
  });
}
