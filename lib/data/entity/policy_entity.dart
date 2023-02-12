import 'package:json_annotation/json_annotation.dart';

part 'policy_entity.g.dart';

@JsonSerializable()
class PolicyEntity {
  final int policyId;
  final String title;
  final String content;

  PolicyEntity(this.policyId, this.title, this.content);

  factory PolicyEntity.fromJson(Map<String, dynamic> json) => _$PolicyEntityFromJson(json);

  Map<String, dynamic> toJson() => _$PolicyEntityToJson(this);
}
