import '../../model/token.dart';

abstract class LoginRepository {
  Future<Token> fetchLogin(Map<String, dynamic> query);
}
