import 'package:json_annotation/json_annotation.dart';

part 'member_entity.g.dart';

@JsonSerializable()
class MemberEntity {
  final int id;
  final String email;
  final String nickname;
  final String providerEmail;

  MemberEntity(this.id, this.email, this.nickname, this.providerEmail);

  factory MemberEntity.fromJson(Map<String, dynamic> json) => _$MemberEntityFromJson(json);

  Map<String, dynamic> toJson() => _$MemberEntityToJson(this);
}
