import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'member_model.g.dart';

abstract class MemberModelBase {}

class MemberModelInit implements MemberModelBase {}

class MemberModelSignUp implements MemberModelBase {
  final String signToken;

  MemberModelSignUp(this.signToken);
}

class MemberModelLoading implements MemberModelBase {}

class MemberModelError implements MemberModelBase {
  final String? message;

  MemberModelError({this.message});
}

@JsonSerializable()
class MemberModel implements MemberModelBase {
  final int id;
  final String email;
  final String nickname;
  final String providerEmail;
  final String? profileImage;

  MemberModel({
    required this.id,
    required this.email,
    required this.nickname,
    required this.providerEmail,
    required this.profileImage,
  });

  factory MemberModel.fromJson(Map<String, dynamic> json) => _$MemberModelFromJson(json);

  Map<String, dynamic> toJson() => _$MemberModelToJson(this);

  factory MemberModel.convertUtf8({required MemberModel model}) {
    final nickname = const Utf8Decoder().convert(model.nickname.codeUnits);

    return MemberModel(
      id: model.id,
      email: model.email,
      nickname: nickname,
      providerEmail: model.providerEmail,
      profileImage: model.profileImage,
    );
  }
}
