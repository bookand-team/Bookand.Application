import 'package:json_annotation/json_annotation.dart';

part 'policy_model.g.dart';

abstract class PolicyModelBase {}

class PolicyModelInit implements PolicyModelBase {}

class PolicyModelLoading implements PolicyModelBase {}

@JsonSerializable()
class PolicyModel implements PolicyModelBase {
  final int policyId;
  final String title;
  final String content;

  PolicyModel(this.policyId, this.title, this.content);

  factory PolicyModel.fromJson(Map<String, dynamic> json) => _$PolicyModelFromJson(json);

  Map<String, dynamic> toJson() => _$PolicyModelToJson(this);

  PolicyModel copyWith({
    int? policyId,
    String? title,
    String? content,
  }) {
    return PolicyModel(
      policyId ?? this.policyId,
      title ?? this.title,
      content ?? this.content,
    );
  }
}
