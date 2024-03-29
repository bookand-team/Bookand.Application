import 'package:bookand/core/const/social_type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'member_model.g.dart';

@JsonSerializable()
class MemberModel {
  final int id;
  final String email;
  final String nickname;
  final String providerEmail;
  final String profileImage;
  final SocialType providerType;

  MemberModel({
    this.id = 0,
    this.email = '',
    this.nickname = '',
    this.providerEmail = '',
    this.profileImage = '',
    this.providerType = SocialType.NONE,
  });

  factory MemberModel.fromJson(Map<String, dynamic> json) => _$MemberModelFromJson(json);

  Map<String, dynamic> toJson() => _$MemberModelToJson(this);
}
