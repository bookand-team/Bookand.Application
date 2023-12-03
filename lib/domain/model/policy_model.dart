import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'policy_model.g.dart';

@JsonSerializable()
@HiveType(typeId: 0)
class PolicyModel {
  @HiveField(0)
  final int policyId;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String content;

  PolicyModel({
    this.policyId = 0,
    this.title = '',
    this.content = '',
  });

  factory PolicyModel.fromJson(Map<String, dynamic> json) => _$PolicyModelFromJson(json);

  Map<String, dynamic> toJson() => _$PolicyModelToJson(this);
}
