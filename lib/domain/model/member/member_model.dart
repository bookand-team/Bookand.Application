import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'member_model.g.dart';

@JsonSerializable()
class MemberModel {
  final int id;
  final String email;
  final String nickname;
  final String providerEmail;
  final String profileImage;

  MemberModel({
    this.id = 0,
    this.email = '',
    this.nickname = '',
    this.providerEmail = '',
    this.profileImage = '',
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
