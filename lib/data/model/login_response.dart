import 'package:bookand/data/model/token.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../common/const/login_result.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  final Token token;
  final LoginResult result;

  LoginResponse({required this.token, required this.result});

  factory LoginResponse.fromJson(Map<String, dynamic> json) => _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}
