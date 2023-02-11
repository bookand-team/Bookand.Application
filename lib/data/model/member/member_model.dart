import 'package:json_annotation/json_annotation.dart';

part 'member_model.g.dart';

abstract class MemberModelBase {}

class MemberModelInit implements MemberModelBase {}

class MemberModelSignUp implements MemberModelBase {}

class MemberModelLoading implements MemberModelBase {}

class MemberModelError implements MemberModelBase {}

@JsonSerializable()
class MemberModel implements MemberModelBase {
  final int id;
  final String email;
  final String nickname;
  final String providerEmail;

  MemberModel(this.id, this.email, this.nickname, this.providerEmail);

  factory MemberModel.fromJson(Map<String, dynamic> json) => _$MemberModelFromJson(json);

  Map<String, dynamic> toJson() => _$MemberModelToJson(this);
}
