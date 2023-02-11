import 'package:json_annotation/json_annotation.dart';

part 'member_profile_update.g.dart';

@JsonSerializable()
class MemberProfileUpdate {
  final String nickname;

  MemberProfileUpdate(this.nickname);

  factory MemberProfileUpdate.fromJson(Map<String, dynamic> json) =>
      _$MemberProfileUpdateFromJson(json);

  Map<String, dynamic> toJson() => _$MemberProfileUpdateToJson(this);
}
