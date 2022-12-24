// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) =>
    LoginResponse(
      token: Token.fromJson(json['token'] as Map<String, dynamic>),
      result: $enumDecode(_$LoginResultEnumMap, json['result']),
    );

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) =>
    <String, dynamic>{
      'token': instance.token,
      'result': _$LoginResultEnumMap[instance.result]!,
    };

const _$LoginResultEnumMap = {
  LoginResult.OK: 'OK',
  LoginResult.NEW_USER: 'NEW_USER',
};
